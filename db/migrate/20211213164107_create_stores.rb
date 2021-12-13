class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
