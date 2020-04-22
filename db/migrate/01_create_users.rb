class CreateUser < ActiveRecord::Migration
    create_table :users do |t|
        t.string :username
        t.string :password_digest
    end
end