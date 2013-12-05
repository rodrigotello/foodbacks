class FixInvitedNameInFoodbacks < ActiveRecord::Migration
  def up
  	rename_column :foodbacks, :invited, :invited_name
  end

  def down
  end
end
