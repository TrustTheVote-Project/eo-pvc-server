class CreateVoterRecords < ActiveRecord::Migration[5.2]
  def change
 
    create_table :voter_records do |t|
      t.timestamps
    end
    
    enable_extension :citext

    add_column :voter_records, :first_name, :citext
    add_column :voter_records, :last_name, :citext
    add_column :voter_records, :dob, :date
              
    add_column :voter_records, :address1, :string
    add_column :voter_records, :address2, :string
    add_column :voter_records, :address3, :string
    add_column :voter_records, :postal_code, :citext
              
    add_column :voter_records, :record_locator, :string
    add_column :voter_records, :registration_id, :string
    add_column :voter_records, :demo_id, :string
              
    add_column :voter_records, :is_absentee, :boolean
    add_column :voter_records, :is_vote_by_mail, :boolean
    
  end
end
