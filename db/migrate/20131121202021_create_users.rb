class CreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      ## Database authenticatable
      t.string :username
      t.string :name

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
