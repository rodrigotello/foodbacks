class User < ActiveRecord::Base
  attr_accessible :email, :name
  
  has_many :authentications
  has_many :foodbacks
  has_many :invitations, foreign_key: "invited_id"
  has_many :invites, through: :invitations, source: :foodback

  before_save :fbname
  after_save :tempinvites

  def fbname
  	self.name = self.auth_hash.info.name
  	self.email = self.auth_hash.extra.raw_info.email
  	self.uid = self.auth_hash.uid
  end  

  def tempinvites #Busca si hay invitaciones temporales y se las asigna
  	TemporalInvitation.all.each do |ti|
  		if ti.uid == self.uid
  			Invitation.create(foodback_id: ti.foodback_id, invited_id: self.id)
  			ti.delete
  		end
  	end
  end

end
