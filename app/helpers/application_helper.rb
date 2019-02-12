module ApplicationHelper
  def notifications_header
    content_tag(:h2, []) do
      image_tag('alert.png') + t('notification.header')
    end
  end
  
end
