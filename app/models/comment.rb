class Comment < ActiveRecord::Base

  belongs_to :ticket

  validates_presence_of :message
end
