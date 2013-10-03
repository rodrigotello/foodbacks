class AddCoverToFoodbacks < ActiveRecord::Migration
  def self.up
  	add_attachment :foodbacks, :cover
  end

  def self.down
  	remove_attachment :foodbacks, :cover
  end
end