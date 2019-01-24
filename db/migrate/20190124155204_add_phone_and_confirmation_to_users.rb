class AddPhoneAndConfirmationToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :phone, :string
    add_column :users, :confirmed_registration, :boolean
  end
end
