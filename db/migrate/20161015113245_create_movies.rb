class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :video_url
      t.decimal :price, precision: 8, scale: 2
      t.integer :level, default: 0
      t.attachment :image
      t.text :vimeo

      t.timestamps null: false
    end
  end
end
