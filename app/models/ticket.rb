class Ticket < ActiveRecord::Base
  has_one :owner, -> { where type: 'owner' }, class_name: 'User'
  has_one :stuff, -> { where type: 'stuff' }, class_name: 'User'
end
