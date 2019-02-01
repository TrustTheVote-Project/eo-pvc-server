class AddRegistrationApprovedNotificationsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :registration_approved_notifications, :string
  end
end
