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
  
  def delivery_option
    @delivery_option ||= user&.send(notification_type).to_s.to_sym
  end
  
  def deliver
    if delivery_option && delivery_option != "none"
      if delivery_option == :app || true # Just fake as if all options are in-app
        # TODO execute the push
      end
      #raise delivery_option.to_s
    else
      # This notification won't be delivered
    end
  end
  
  def as_json(options={}) 
    super({methods: [:title]}.merge(options))
  end
  
  def dismiss!
    self.delivered = true
    self.delivered_at = DateTime.now
    self.save(validate: false)
  end
    
end

