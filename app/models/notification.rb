class Notification < ApplicationRecord
  
  belongs_to :user

  validates_presence_of :notification_type

  after_create :deliver

  def self.types
    User.notification_types.collect {|t| t.gsub('_notifications','')}
  end
  
  def self.available_types
    self.types.select {|t| !I18n.t("notification.types.#{t}.short", default: '').blank? }
  end

  def key
    notification_type.to_s.gsub('_notifications','')
  end

  def label
    I18n.t("notification.types.#{key}.label")
  end

  def title
    I18n.t("notification.types.#{key}.title")
  end

  def notification_type_enum
    # Do not select any value, or add any blank field. RailsAdmin will do it for you.
    self.class.available_types.collect {|t|[I18n.t("notification.types.#{t}.title"), "#{t}_notifications"]}
    # alternatively
    # { green: 0, white: 1 }
    # [ %w(Green 0), %w(White 1)]
  end
  
  def delivery_option
    @delivery_option ||= user&.preference(notification_type).to_s.to_sym 
  end
  
  def deliver
    case notification_type
    when "registration_approved_notifications"
      # also set status
      user.approve_registration!
    when "by_mail_ballot_notifications"
      user.approve_by_mail_ballot!
    when "reregistration_deadline_notifications"
      user.registration_deadline_passed!
    end
    # if delivery_option && delivery_option != "none"
    #   if delivery_option == :app || true # Just fake as if all options are in-app
    #     # TODO execute the push
    #   end
    #   #raise delivery_option.to_s
    # else
    #   # This notification won't be delivered
    # end
  end
  
  def default_content    
    case notification_type        
    when "reregistration_deadline_notifications", "registration_deadline_notifications"
      if user.is_registered?
        I18n.t("notification.types.#{key}.alternate.short")
      else
        I18n.t("notification.types.#{key}.short")        
      end
    else
      I18n.t("notification.types.#{key}.short")
    end
  end
  
  def long_content
    case notification_type        
    when "reregistration_deadline_notifications", "registration_deadline_notifications"
      if user.is_registered?
        I18n.t("notification.types.#{key}.alternate.long")
      else
        I18n.t("notification.types.#{key}.long")        
      end
    else
      I18n.t("notification.types.#{key}.long")
    end
  end

  
  def as_json(options={}) 
    super({methods: [:title, :default_content]}.merge(options))
  end
  
  def dismiss!
    self.delivered = true
    self.delivered_at = DateTime.now
    self.save(validate: false)
  end
    
end

