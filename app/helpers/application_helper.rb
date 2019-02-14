module ApplicationHelper
  def notifications_header(back_to = nil)
    content_tag(:div, [], class: "header") do
      html = content_tag(:h2, []) do
        image_tag('alert.png') + t('notification.header')
      end
      if back_to
        html += link_to t('notification.back'), back_to
      end
      html      
      
    end
  end
  
  def services_header(back_to = nil)
    content_tag(:div, [], class: "header") do
      html = content_tag(:h2, []) do
        html = image_tag('tools.png') + t('services.header')
      end
      if back_to
        html += link_to t('services.back'), back_to
      end
      html      
    end
  end
end
