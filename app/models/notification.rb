class Notification < ApplicationRecord
  
  belongs_to :user

  validates_presence_of :notification_type

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
    @delivery_option ||= user&.preference(notification_type).to_s.to_sym 
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
  
  def default_content
    content.blank? ? "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce rhoncus vehicula ipsum nec ultricies." : content
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

