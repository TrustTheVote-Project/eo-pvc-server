class UsersController < ApplicationController
  
  def fake_eo_registration
    @user = current_user
    render layout: "eo_registration"
  end
  def submit_fake_eo_registration
    @user = current_user
    @user.is_registered = true
    @user.registration_id = "fake-id"
    # TODO deliver a notification in a min?
    @user.save!
    render layout: "eo_registration"
  end

  
  def show
    @user = current_user
    if !@user.confirmed_registration?
      if !@user.registration_id        
        render :new_registrant
      else
        if @user.record_locator
          render :confirm_with_locator
        else
          render :confirm
        end
      end
    elsif !@user.registration_id
      render :start_online_registration
    elsif !@user.set_notifications?
      render :edit_notifications
    elsif @user.needs_phone? || @user.needs_email?
      render :edit_contacts
    end
  end
  
  
  def new_registrant
    @user = current_user
  end
  
  def start_online_registration
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
    if params[:select_address] == "none"
      user.registration_id = nil
      user.save
      @user = user
      @matched_without_address = t('confirm.matched_without_address')
      render :new_registrant    
    else
      user.update_attributes!(user_params)
      redirect_to action: :show
    end
  end
  
  def confirm_registration
    current_user.update_attributes(confirmed_registration: true)
    redirect_to edit_notifications_user_path
  end
  
  private
  def user_params
    params.require(:user).permit([:first_name, :last_name, :dob_day, :dob_month, :dob_year, :address1, :address2, :address3, :postal_code, :email, :phone, :confirmed_registration, :global_preference, :global_receive_email] + (User.notification_types))
  end
  
end
