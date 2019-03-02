class AddSampleDataFieldsd < ActiveRecord::Migration[5.2]
  def change
    add_column :voter_records, :middle_name, :string
    remove_column :voter_records, :is_vote_by_mail, :boolean
    add_column :voter_records, :is_special_ballot, :boolean
    
    add_column :users, :middle_name, :string
  end
end
