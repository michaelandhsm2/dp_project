class AddDateToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :date, :DateTime
  end
end