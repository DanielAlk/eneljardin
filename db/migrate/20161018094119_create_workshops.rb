class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.text :information
      t.integer :level
      t.decimal :price, precision: 8, scale: 2
      t.attachment :image
      t.string :slug

      t.timestamps null: false
    end
    add_index :workshops, :slug, unique: true
  end
end
