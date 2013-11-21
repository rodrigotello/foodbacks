class Category < ActiveRecord::Base
  attr_accessible :name, :category_id

  has_and_belongs_to_many :foodbacks
  
end
