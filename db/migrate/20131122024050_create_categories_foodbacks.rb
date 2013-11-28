class CreateCategoriesFoodbacks < ActiveRecord::Migration
  def change
    create_table :categories_foodbacks do |t|
    	t.belongs_to :foodback
    	t.belongs_to :category


    end
    add_index :categories_foodbacks, [:category_id,:foodback_id]
  end
end
