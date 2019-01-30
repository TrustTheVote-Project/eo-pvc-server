class AddStatusesToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :read, :boolean
    add_column :notifications, :read_at, :date_time
    add_column :notifications, :delivered, :boolean
    add_column :notifications, :delivered_at, :date_time
    add_column :notifications, :delivery_receipt, :string
  end
end
