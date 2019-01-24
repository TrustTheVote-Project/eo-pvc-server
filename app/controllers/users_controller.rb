class UsersController < ApplicationController
  
  def show
    @user = current_user
    if !@user.confirmed_registration?
      if !@user.registration_id
        render :new_registrant
      else
        render :confirm
      end
    elsif !@user.set_notifications?
      render :edit_notifications
    elsif @user.needs_phone? || @user.needs_email?
      render :edit_contacts
    end
  end
  
  
  def new_registrant
    @user = current_user
  end
  
  def edit_contacts
    @user = current_user
  end
  
  def edit_notifications
    @user = current_user
  end
  
  def update
    user = current_user
    user.update_attributes!(user_params)
    redirect_to action: :show
  end
  
  def confirm_registration
    current_user.update_attributes(confirmed_registration: true)
    redirect_to edit_notifications_user_path
  end
  
  private
  def user_params
    params.require(:user).permit([:first_name, :last_name, :dob_day, :dob_month, :dob_year, :address1, :address2, :address3, :postal_code, :email, :phone, :confirmed_registration] + (User.notification_types))
  end
  
end
