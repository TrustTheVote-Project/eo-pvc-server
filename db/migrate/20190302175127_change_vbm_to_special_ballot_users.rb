class ChangeVbmToSpecialBallotUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :is_vote_by_mail, :boolean
    add_column :users, :is_special_ballot, :boolean
    
    add_column :users, :is_special_ballot_approved, :boolean
    add_column :users, :is_special_ballot_pending, :boolean
  end
end
