class AddGamesToOwners < ActiveRecord::Migration
  def change
    add_column :users, :games, :string
  end
end
