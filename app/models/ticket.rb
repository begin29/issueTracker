class Ticket < ActiveRecord::Base
  extend FriendlyId
  # TODO: Ticket.find('slug') doesn`t work.
  friendly_id :generate_slug, use: [:slugged, :finders]

  belongs_to :customer, -> { where user_type: 'customer' }, class_name: 'User'
  belongs_to :stuff, -> { where user_type: 'stuff' }, class_name: 'User'

  accepts_nested_attributes_for :customer

  def generate_slug
    digits = [*('1'..'9')]
    letters = [*('a'..'z')]
    "#{letters.sample_three}-#{ digits.sample_three}-#{letters.sample_three}-#{ digits.sample_three}-#{letters.sample_three}"
  end
end
