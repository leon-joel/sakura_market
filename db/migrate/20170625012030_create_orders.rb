class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :user, foreign_key: true
      t.string :send_to_address, null: false
      t.date :deliver_date
      t.string :deliver_time_range

      t.timestamps null: false
    end
  end
end
