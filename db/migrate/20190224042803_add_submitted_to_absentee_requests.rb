class AddSubmittedToAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :absentee_requests, :submitted, :boolean
    add_column :absentee_requests, :approved, :boolean
  end
end
