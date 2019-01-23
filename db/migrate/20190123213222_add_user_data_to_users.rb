class AddUserDataToUsers < ActiveRecord::Migration[5.2]
  def change
    enable_extension :citext
 
    add_column :users, :first_name, :citext
    add_column :users, :last_name, :citext
    add_column :users, :dob_day, :integer
    add_column :users, :dob_month, :integer
    add_column :users, :dob_year, :integer

    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :address3, :string
    add_column :users, :postal_code, :citext
    
    add_column :users, :record_locator, :string
    add_column :users, :registration_id, :string
    add_column :users, :demo_id, :string
    
    add_column :users, :is_registered, :boolean
    add_column :users, :is_absentee, :boolean
    add_column :users, :is_vote_by_mail, :boolean
    
    add_column :users, :registration_deadline_notifications, :string
    add_column :users, :reregistration_deadline_notifications, :string
    add_column :users, :change_detected_notifications, :string
    add_column :users, :upcoming_election_notifications, :string
    add_column :users, :election_change_notificatinos, :string
    add_column :users, :election_day_notifications, :string
    add_column :users, :mailing_notifications, :string
    add_column :users, :ballot_notifications, :string    
    
    
    add_index :users, [:first_name, :last_name, :dob_day, :dob_month, :dob_year, :postal_code], name: :index_uses_on_identifiers
  end
end
