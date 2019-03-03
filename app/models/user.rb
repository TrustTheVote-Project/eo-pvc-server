class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :email, uniqueness: { case_sensitive: false, allow_blank: true}
  
  has_many :notifications, dependent: :destroy
  has_many :absentee_requests, dependent: :destroy
  
  before_save :check_needs_reregistration, on: :update

  
  NOTIFICATION_PREF_OPTIONS = %w(none sms email app)
  
  def self.notification_types
    User.column_names.select {|n| n =~ /_notifications$/ }
  end
  
  def update_from_voter_record(voter_record)
    # TODO set all the values from the voter record
    self.registration_id = voter_record.id
    self.first_name = voter_record.first_name
    self.middle_name = voter_record.middle_name
    self.last_name = voter_record.last_name
    self.address1 = voter_record.address1
    self.address2 = voter_record.address2
    self.address3 = voter_record.address3
    self.postal_code = voter_record.postal_code
    self.dob_day = voter_record.dob.day
    self.dob_month = voter_record.dob.month
    self.dob_year = voter_record.dob.year
    self.is_absentee = voter_record.is_absentee
    self.is_special_ballot = voter_record.is_special_ballot
    if self.is_absentee
      self.absentee_requests << AbsenteeRequest.new(submitted: true)
    elsif self.is_special_ballot
      self.is_special_ballot_pending = true
    end
  end
  
  
  
  def email_required?
   false
  end       
  
  def set_notifications?
    #notification_preferences.keys.any? || !global_preference.blank?
    notifications_step == notifications_step_count
  end
  
  def notification_steps_remaining
    notifications_step_count - notifications_step
  end
  
  def notifications_step_count
    3
  end
  
  def notifications_step
    if global_preference.blank?
      0
    elsif !preferences_set?
      1
    elsif !services_set?
      2
    else
      3
    end
  end
  
  def preferences_set?
    notification_groups.each do |gk,gv|
      gv.each do |k,v|
        return true if v != nil
      end
    end
    return false
  end
  
  def services_set?
    services_groups.each do |gk,gv|
      if gv.is_a?(Hash)
        gv.each do |k,v|
          return true if  v != nil
        end
      else
        return true if gv != nil
      end
    end
    return false
  end
  
  def approve_registration!
    self.is_registered = true
    self.registration_submitted = false
    self.registration_id = "fake-id"
    if !self.needs_reregistration.blank?
      self.needs_reregistration = nil
      self.reregistration_submitted = false
      self.is_reregistered = true
    end
    self.save(validate: false)
  end
  
  def approve_by_mail_ballot!
    self.absentee_requests.update_all(approved: true)
    if self.is_special_ballot_pending?
      self.is_special_ballot_approved = true
      self.save(validate: false)
    end
  end
  
  def registration_deadline_passed!
    self.is_registration_deadline_passed = true
    self.save(validate: false)
  end
  
  def needs_email?
    notification_preferences.values.include?("email") && email.blank?
  end

  def needs_phone?
    notification_preferences.values.include?("sms") && phone.blank?
  end

  def preference(notification_type)
    pref = self.send(notification_type).to_s
    if pref.blank?
      pref = self.global_preference.to_s
    end
    return pref
  end
  
  def notification_groups
    {
      upcoming_preferences: upcoming_preferences,
      advance_voting_preferences: advance_voting_preferences,
      by_mail_preferences: by_mail_preferences 
    }
  end
  def upcoming_preferences
    {
      upcoming_election: upcoming_election_notifications,
      upcoming_election_options: upcoming_election_options_notifications,
      day_before_election: day_before_election_notifications,
      election_day: election_day_notifications,
      election_results: election_results_notifications,
    }
  end
  def advance_voting_preferences
    {
      advance_voting_open: advance_voting_open_notifications,
      advance_voting_last_day: advance_voting_last_day_notifications,
      advance_voting_closed: advance_voting_closed_notifications,
    }
  end
  def by_mail_preferences
    {
      by_mail_application_open: by_mail_application_open_notifications,
      by_mail_application_reminder: by_mail_application_reminder_notifications,
      special_ballot_voting_open: special_ballot_voting_open_notifications,
      special_ballot_voting_remdiner: special_ballot_voting_remdiner_notifications,
      special_ballot_voting_closed: special_ballot_voting_closed_notifications,
    }
  end
  
  def services_groups
    {
      registration: registration_service_preferences,
      by_mail_deadlines: by_mail_deadlines_preferences,
      by_mail_ballot: by_mail_ballot_notifications,
      online_special_ballot_available: online_special_ballot_available_notifications,
      sample_ballot_available: sample_ballot_available_notifications,
      dvic_available: dvic_available_notifications    
    }
  end
  def registration_service_preferences
    {
      registration_deadline: registration_deadline_notifications,
      reregistration_deadline: reregistration_deadline_notifications,
      registration_approved: registration_approved_notifications,
    }
  end
  def by_mail_deadlines_preferences
    {
      by_mail_application_deadline: by_mail_application_deadline_notifications,
      by_mail_submission_deadline: by_mail_submission_deadline_notifications
    }
  end
  def by_mail_ballot_preferences
    {
      by_mail_ballot: by_mail_ballot_notifications,
    }
  end
  def online_special_ballot_preferences
    {
      online_special_ballot_available: online_special_ballot_available_notifications,
    }
  end
  def sample_ballot_preferences
    {
      sample_ballot_available: sample_ballot_available_notifications,
    }
  end
  def dvic_preferences
    {
      dvic_available: dvic_available_notifications,      
    }
  end
  
  
  def notification_preferences
    ns = {}
    User.notification_types.each do |m|
      pref = self.send(m)
      if pref
        ns[m] = pref
      end
    end
    ns
  end
  
  def name
    "#{first_name} #{middle_name} #{last_name}"
  end
  
  def home_address
    [address1, address2, address3, postal_code].compact.join(", ")
  end
  def home_address_lines
    [address1, address2, address3, postal_code].collect{|v| v.blank? ? nil : v}.compact
  end
  def dob
    Date.parse("#{dob_year}-#{dob_month}-#{dob_day}")
  end

  def address_changed?
    address1_changed? || address2_changed? || address3_changed? || postal_code_changed?
  end
  
  def name_changed?
    first_name_changed? || last_name_changed?
  end

  def check_needs_reregistration
    if is_registered?
      if name_changed?
        if address_changed?
          self.needs_reregistration = "name_and_address"
        else
          self.needs_reregistration = "name"
        end
      elsif address_changed?
        self.needs_reregistration = "address"
      end
    end
  end
  
end
