class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :send_to_name, null: false
      t.string :send_to_address, null: false
      t.date :delivery_date
      t.integer :delivery_time_range, null: false, default: 0
      # t.integer :postage, null: false   # 送料
      # t.integer :cod_fee, null: false   # 代引き手数料 cash on delivery fee
      # t.integer :tax, null: false       # 消費税

      t.timestamps null: false
    end
  end
end
