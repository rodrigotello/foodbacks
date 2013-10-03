class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  has_many :authentications
  has_many :foodbacks

end
