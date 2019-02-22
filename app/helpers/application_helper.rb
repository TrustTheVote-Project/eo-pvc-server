module ApplicationHelper
  def notifications_header(back_to = nil)
    header_block(back_to, 'alert.png', 'notification')    
  end
  
  def services_header(back_to = nil)
    header_block(back_to, 'tools.png', 'services')    
  end
  
  def settings_header(back_to = nil)
    header_block(back_to, 'settings.png', 'preferences')
  end
  
  private
  def header_block(back_to=nil, image_name, key_base)
    content_tag(:div, [], class: "header") do
      html = content_tag(:h2, []) do
        html = image_tag(image_name) + t("#{key_base}.header")
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
