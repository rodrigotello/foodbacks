class CreateTemporalInvitations < ActiveRecord::Migration
  def change
    create_table :temporal_invitations do |t|
	  t.integer :uid
      t.integer :foodback_id

      t.timestamps
    end
    add_index :temporal_invitations, :uid
  end
end
