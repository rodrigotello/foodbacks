class Authentication < ActiveRecord::Base
  attr_accessible :provider, :uid, :oauth_token
  belongs_to_ninsho :user
  # attr_accessible :title, :body

  before_save :set_token
  def set_token
    self.token = self.auth_hash.credentials.token
  end
end
