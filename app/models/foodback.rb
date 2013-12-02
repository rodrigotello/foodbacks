class Foodback < ActiveRecord::Base
  attr_accessible :user_id, :address, :city, :content, :cover, :date, :dish, :invited, :invitedmail, :recipe, :title
  
  belongs_to :user
  belongs_to :city

  has_and_belongs_to_many :categories

  has_attached_file :cover

  has_one :invited, through: :invitation, source: :invited

  validates :user_id, presence: true
  validates :title, presence: true
  validates :address, presence: true
  validates :content, presence: true
  #validates :date, presence: true
  validates :invited, presence: true
  validates :dish, presence: true
  
end
