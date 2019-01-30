class AddStatusesToNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :notifications, :read, :boolean
    add_column :notifications, :read_at, :datetime
    add_column :notifications, :delivered, :boolean
    add_column :notifications, :delivered_at, :datetime
    add_column :notifications, :delivery_receipt, :string
  end
end
