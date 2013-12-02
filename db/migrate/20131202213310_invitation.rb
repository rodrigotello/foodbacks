class Invitation < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :invited_id
      t.integer :foodback_id

      t.timestamps
    end
    add_index :invitations, :invited_id
    add_index :invitations, :foodback_id
  end
end