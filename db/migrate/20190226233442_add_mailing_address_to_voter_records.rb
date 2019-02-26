class AddMailingAddressToVoterRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :voter_records, :mailing_address	, :string
    add_column :voter_records, :mailing_place	, :string
    add_column :voter_records, :mailing_province, :string
    add_column :voter_records, :mailing_postal_code, :string
  end
end
