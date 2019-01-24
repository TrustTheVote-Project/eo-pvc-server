class Notification < ApplicationRecord
  
  belongs_to :user

  after_create :deliver

  def title
    notification_type.to_s.gsub('_notifications','').titleize
  end

  def notification_type_enum
    # Do not select any value, or add any blank field. RailsAdmin will do it for you.
    User.notification_types.collect {|t|[t.gsub('_notifications','').titleize, t]}
    # alternatively
    # { green: 0, white: 1 }
    # [ %w(Green 0), %w(White 1)]
  end
  
  def deliver
    delivery_option = user&.send(notification_type)
    if delivery_option && delivery_option != "none"
      #raise delivery_option.to_s
    else
      # This notification won't be delivered
    end
  end
    
end

