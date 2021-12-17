class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.integer :quantity_available
      t.integer :discount
      t.decimal :price, default: 0
      t.integer :status, default: 1

      t.timestamps
    end
  end
end
