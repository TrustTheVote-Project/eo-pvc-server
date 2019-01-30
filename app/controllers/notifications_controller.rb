class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end
  
  def dismiss
    @notification = Notification.find(params[:id])
    @notification.dismiss!
    render json: {}
  end
  
  def check_new
    user = User.find(params[:user_id])
    @notifications = user.notifications.where(delivered: false)
    respond_to do |format|
      format.json do
        render json: {notifications: @notifications}
      end
    end        
  end
  
end
