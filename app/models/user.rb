class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  validates :email, uniqueness: { case_sensitive: false, allow_blank: true}
  
  has_many :notifications
  
  NOTIFICATION_PREF_OPTIONS = %w(none sms email app)
  
  def self.notification_types
    User.column_names.select {|n| n =~ /_notifications$/ }
  end
  
  def update_from_voter_record(voter_record)
    # TODO set all the values from the voter record
    self.registration_id = voter_record.id
    self.first_name = voter_record.first_name
    self.last_name = voter_record.last_name
    self.address1 = voter_record.address1
    self.address2 = voter_record.address2
    self.address3 = voter_record.address3
    self.postal_code = voter_record.postal_code
    self.dob_day = voter_record.dob.day
    self.dob_month = voter_record.dob.month
    self.dob_year = voter_record.dob.year
    self.is_absentee = voter_record.is_absentee
    self.is_vote_by_mail = voter_record.is_vote_by_mail
  end
  
  
  
  def email_required?
   false
  end       
  
  def set_notifications?
    notification_preferences.keys.any?
  end
  
  def needs_email?
    notification_preferences.values.include?("email") && email.blank?
  end

  def needs_phone?
    notification_preferences.values.include?("sms") && phone.blank?
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
    "#{first_name} #{last_name}"
  end
  
  def home_address
    [address1, address2, address3, postal_code].compact.join(", ")
  end
  
  def dob
    Date.parse("#{dob_year}-#{dob_month}-#{dob_day}")
  end
  
end
