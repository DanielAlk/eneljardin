class CreateWorkshops < ActiveRecord::Migration
  def change
    create_table :workshops do |t|
      t.string :title
      t.text :description
      t.text :information
      t.integer :level
      t.decimal :price, precision: 8, scale: 2
      t.attachment :image

      t.timestamps null: false
    end
  end
end
