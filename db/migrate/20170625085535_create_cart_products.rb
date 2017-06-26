class CreateCartProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_products do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :quantity, null: false, default: 1

      t.timestamps null: false
    end
  end
end
