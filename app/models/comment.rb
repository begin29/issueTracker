class Comment < ActiveRecord::Base

  belongs_to :ticket
  belongs_to :user
  belongs_to :parent, class_name: 'Comment'
  has_many :childrens, class_name: 'Comment', foreign_key: 'parent_id'

  validates_presence_of :message

  scope :parent_comments, -> { where(parent_id: nil) }
end
