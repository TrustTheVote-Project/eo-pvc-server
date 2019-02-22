class AddStepNumberToAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :absentee_requests, :step_number, :integer
  end
end
