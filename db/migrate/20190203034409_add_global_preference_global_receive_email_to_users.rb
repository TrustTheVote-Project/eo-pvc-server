class AddGlobalPreferenceGlobalReceiveEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :global_preference, :string
    add_column :users, :global_receive_email, :boolean
  end
end
