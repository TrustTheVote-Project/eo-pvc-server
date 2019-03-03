class AddSelectionsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :sample_ballot_selection, :string
    add_column :users, :online_ballot_selection, :string
  end
end
