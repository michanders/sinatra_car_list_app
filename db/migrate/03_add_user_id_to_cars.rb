class AddUserIdToCars < ActiveRecord::Migration[4.2]

  def change
    add_column :cars, :user_id, :integer
  end
end
