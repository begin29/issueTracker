class Comment < ActiveRecord::Base

  belongs_to :ticket
  belongs_to :user

  validates_presence_of :message
end
