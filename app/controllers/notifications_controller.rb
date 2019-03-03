class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
    if params[:cancel_notification]
      current_user.send("#{params[:cancel_notification]}=", false)
      current_user.save(validate: false)
    end
  end
  
  def show
    @notification = Notification.find(params[:id])
    @notification.read = true
    @notification.save(validate: false)
    if params[:cancel_notification]
      current_user.send("#{params[:cancel_notification]}=", false)
      current_user.save(validate: false)
    end
  end
  
  def dismiss
    @notification = Notification.find(params[:id])
    @notification.dismiss!
    render json: {}
  end
  
  def check_new
    user = User.find(params[:user_id])
    @notifications = user.notifications.where("delivered = ? OR delivered IS NULL", false)
    respond_to do |format|
      format.json do
        render json: {notifications: @notifications}
      end
    end        
  end
  
  def cancel
    @notification = Notification.find params[:id]
    # cancel the notification *type*
  end
  
end
