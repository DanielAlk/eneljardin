class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.references :workshop, index: true, foreign_key: true
      t.string :title
      t.text :description
      t.attachment :image
      t.attachment :note

      t.timestamps null: false
    end
  end
end
