class CreatePaymentWorkshops < ActiveRecord::Migration
  def change
    create_table :payment_workshops do |t|
      t.references :payment, index: true, foreign_key: true
      t.references :workshop, index: true, foreign_key: true
      t.decimal :price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
