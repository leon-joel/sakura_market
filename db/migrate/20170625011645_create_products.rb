class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :picture, null: false, default: ''
      t.integer :price, null: false, default: 99999999
      t.string :description, null: false, default: ''
      t.boolean :is_visible, null: false, default: false
      t.integer :display_order, null: false, default: 0

      t.timestamps null: false
    end
  end
end
