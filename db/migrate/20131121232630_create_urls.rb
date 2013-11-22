class CreateUrls < ActiveRecord::Migration
  def change
    create_table :urls do |t|
      t.string :full
      t.string :slug
      t.references :user

      t.timestamps
    end
    add_index :urls, :slug, unique: true
  end
end
