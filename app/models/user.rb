class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  has_many :authentications
  has_many :foodbacks

  before_save :fbname
  def fbname
  	self.name = self.auth_hash.info.name
  	self.email = self.auth_hash.extra.raw_info.email
  	self.uid = self.auth_hash.uid
  end  

end
