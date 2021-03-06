module ApplicationHelper
  def notification_button(n)
    button_text = I18n.t("notification.types.#{n.key}.button")
    button_url = case n.notification_type        
    when "upcoming_election_options_notifications", "advance_voting_open_notifications", "dvic_available_notifications", "registration_approved_notifications"
      dvic_services_path
    when "by_mail_application_reminder_notifications"
      by_mail_services_path
    when "registration_deadline_notifications"
      register_online_services_path
    when "reregistration_deadline_notifications"
      register_same_day_services_path
    when "online_special_ballot_available_notifications"
      online_special_ballot_services_path
    when "sample_ballot_available_notifications"
      sample_ballot_services_path
    else
      nil
    end
    if button_url
      return link_to button_text, button_url, class: :button
    else
      ""
    end
  end
  
  def notifications_header(back_to = nil)
    header_block('alert.png', 'notification', back_to)    
  end
  
  def information_header
    header_block('info.png', 'information')
  end
  
  def services_header(back_to = nil)
    header_block('tools.png', 'services', back_to)    
  end
  
  def service_header(service_type, service_sub_type=nil, back_to=nil)
    image = t("services.#{service_type}.icon")
    key_base = "services.#{service_type}"
    sub_text = nil
    if service_sub_type
      sub_text = t("services.#{service_type}.#{service_sub_type}.header")
    end
    
    header_block(image, key_base, back_to, sub_text)
  end
  
  def settings_header(back_to = nil, sub_text=nil)
    header_block('settings.png', 'preferences', back_to, sub_text)
  end
  
  private
  def header_block(image_name, key_base, back_to=nil, sub_text=nil)
    content_tag(:div, [], class: "header") do
      html = content_tag(:h2, []) do
        html = image_tag(image_name) + t("#{key_base}.header")
      end
      if sub_text
        html += content_tag(:p) do
          sub_text
        end
      end
      if back_to
        html += link_to t("#{key_base}.back"), back_to
      end
      
      html      
    end
    
  end
  
  # def prompt_user
  #   if !current_user.set_notifications?
  #     content_tag(:div, [], class: 'prompt') do
  #       link_to
  #     end
  #   end
  # end

  
end
