class GameList < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :first_game
      t.string :second_game
      t.string :third_game
      t.string :fourth_game
      t.string :fifth_game
      t.integer :user_id
    end
  end
end
