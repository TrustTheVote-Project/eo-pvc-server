module ApplicationHelper
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
  
  def settings_header(back_to = nil)
    header_block('settings.png', 'preferences', back_to)
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
