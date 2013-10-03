class CreateFoodbacks < ActiveRecord::Migration
  def change
    create_table :foodbacks do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :cover
      t.string :invited
      t.string :invitedmail
      t.datetime :date
      t.integer :city
      t.string :address
      t.string :dish
      t.text :recipe

      t.timestamps
    end

    add_index :foodbacks, [:user_id, :city, :created_at]
  end
end
