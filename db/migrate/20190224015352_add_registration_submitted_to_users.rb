class AddRegistrationSubmittedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :registration_submitted, :boolean
  end
end
