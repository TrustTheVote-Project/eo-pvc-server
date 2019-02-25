class AddByMailNotifications < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :by_mail_application_deadline_notifications, :boolean
    add_column :users, :by_mail_application_deadline_notification_options, :string
      # numdays [14]
    add_column :users, :by_mail_submission_deadline_notifications, :boolean
    add_column :users, :by_mail_submission_deadline_notification_options, :string
      # numdays [14]
    
  end
end
