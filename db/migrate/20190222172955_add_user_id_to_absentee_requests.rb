class AddUserIdToAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    add_column :absentee_requests, :user_id, :integer
  end
end
