class UpdateUserNotifications < ActiveRecord::Migration[5.2]
  def change
    
    remove_column :users, "registration_deadline_notifications", :string
    remove_column :users, "reregistration_deadline_notifications", :string
    remove_column :users, "change_detected_notifications", :string
    remove_column :users, "upcoming_election_notifications", :string
    remove_column :users, "election_change_notificatinos", :string
    remove_column :users, "election_day_notifications", :string
    remove_column :users, "mailing_notifications", :string
    remove_column :users, "ballot_notifications", :string
    remove_column :users, "registration_approved_notifications", :string
    
    add_column :users, :upcoming_election_notifications, :boolean
    add_column :users, :upcoming_election_options_notifications, :boolean
    add_column :users, :day_before_election_notifications, :boolean
    add_column :users, :election_day_notifications, :boolean
    add_column :users, :election_results_notifications, :boolean

    add_column :users, :advance_voting_open_notifications, :boolean
    add_column :users, :advance_voting_last_day_notifications, :boolean
    add_column :users, :advance_voting_closed_notifications, :boolean
    
    add_column :users, :by_mail_application_open_notifications, :boolean
    add_column :users, :by_mail_application_reminder_notifications , :boolean
    add_column :users, :by_mail_application_reminder_notification_options, :string
       #numdays [14] days
    add_column :users, :special_ballot_voting_open_notifications, :boolean
    add_column :users, :special_ballot_voting_remdiner_notifications, :boolean
    add_column :users, :special_ballot_voting_remdiner_notification_options, :string
       #[14] days before Deadline
    add_column :users, :special_ballot_voting_closed_notifications, :boolean
    
    add_column :users, :registration_deadline_notifications, :boolean
    add_column :users, :registration_deadline_notification_options, :string
      # numdays [14]
    add_column :users, :reregistration_deadline_notifications, :boolean
    add_column :users, :reregistration_deadline_notification_options, :string
      # numdays [7]
    add_column :users, :registration_approved_notifications, :boolean
  
    add_column :users, :by_mail_ballot_notifications, :boolean
    add_column :users, :online_special_ballot_available_notifications, :boolean
    add_column :users, :sample_ballot_available_notifications, :boolean
    add_column :users, :dvic_available_notifications, :boolean
    
  end
end
