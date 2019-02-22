class AddMailingAddressToAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :absentee_requests, :mailing_street_number, :string
    add_column :absentee_requests, :mailing_street_name, :string
    add_column :absentee_requests, :mailing_street_unit, :string
    add_column :absentee_requests, :mailing_city, :string
    add_column :absentee_requests, :mailing_postal_code, :string
  end
end
