class RemoveGamesFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :games
  end
end
