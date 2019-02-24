class AddExemptReasonToAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :absentee_requests, :exempt_reason, :string
  end
end
