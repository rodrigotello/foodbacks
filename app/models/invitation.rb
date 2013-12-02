class Invitation < ActiveRecord::Base
  attr_accessible :invited_id, :foodback_id
  belongs_to :invited, class_name: "User"
  belongs_to :foodback
end