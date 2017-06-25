class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.datetime :order_datetime, null: false
      t.string :send_to, null: false
      t.date :date_to_deliver
      t.string :time_range_to_deliver

      t.timestamps null: false
    end
  end
end
