class Ticket < ActiveRecord::Base
  include Workflow
  extend FriendlyId

  friendly_id :generate_slug, use: :slugged

  belongs_to :stuff, class_name: 'User', foreign_key: :stuff_id
  belongs_to :customer, class_name: 'User', foreign_key: :customer_id
  has_many :comments

  def initialize(attributes = {})
    @user = User.find_by_email(attributes[:customer_attributes][:email]) rescue nil
    super
  end

  accepts_nested_attributes_for :comments, :customer

  accepts_nested_attributes_for :customer,
                                reject_if: !@user.blank?
                                # If customer already exist, system will reject his.

  validates_presence_of :subject, :description

  before_validation :set_exist_user, unless: -> { @user.blank? }

  scope :opened_tickets, ->{where(workflow_state: ['opened', nil, ''])}
  [:on_holded, :closed, :waiting_for_responsed].each do |s|
    scope "#{s}_tickets", ->{where(workflow_state: s)}
  end

  after_create do
    waiting_for_response!
    Sunspot.index! self
  end

  workflow do
    state :opened do
      event :on_hold, transitions_to: :on_holded
      event :close, transitions_to: :closed
      event :waiting_for_response, transitions_to: :waiting_for_responsed
    end
    state :on_holded do
      event :open, transitions_to: :opened
      event :close, transitions_to: :closed
      event :waiting_for_response, transitions_to: :waiting_for_responsed
    end
    state :closed do
      event :open, transitions_to: :opened
      event :on_hold, transitions_to: :on_holded
      event :waiting_for_response, transitions_to: :waiting_for_responsed
    end
    state :waiting_for_responsed do
      event :open, transitions_to: :opened
      event :on_hold, transitions_to: :on_holded
      event :close, transitions_to: :closed
    end
    after_transition do |*args|
      Sunspot.index! self
    end
  end

  searchable do
    text :subject, :description, :customer, :stuff
    text :users do all_users.map { |user| user.full_name } end
    text :slug do slug.split('-') end
    text :full_slug do slug end
    string :workflow_state
    time :created_at
  end

  def all_users
    [customer, stuff].compact
  end

  def generate_slug
    digits = [*('1'..'9')]
    letters = [*('a'..'z')]
    "#{letters.sample_three}-#{digits.sample_three}-#{letters.sample_three}-#{ digits.sample_three}-#{letters.sample_three}"
  end

  def set_exist_user
    self.customer_id = @user.id
  end
end
