class AddListName < ActiveRecord::Migration
  def change
    add_column :games, :list_name, :string
  end
end
