class UsersController < ApplicationController
  
  def fake_eo_registration
    @user = current_user
    @user.registration_submitted = true
    # TODO deliver a notification in a min?
    @user.save!(validate: false)
    render layout: "eo_registration"
  end
  def submit_fake_eo_registration
    @user = current_user
    @user.registration_submitted = true
    # TODO deliver a notification in a min?
    @user.save!
    render layout: "eo_registration"
  end

  
  def show
    @user = current_user
    if !@user.confirmed_registration?
      @hide_alert = true
      @hide_menu = true        
      if !@user.registration_id
        @hide_menu = true        
        render :new_registrant
      else
        if @user.record_locator
          render :confirm_with_locator
        else
          render :confirm
        end
      end
    elsif !@user.registration_id && !@user.registration_submitted?
      render :start_online_registration
    elsif !@user.set_notifications?
      redirect_to action: :edit_notifications
    elsif @user.needs_phone? || @user.needs_email?
      render :edit_contacts
    else
      redirect_to information_path
    end
  end
  
  
  def update_address
    @matched_without_address = t('profile.change_address')
    @user = current_user
    @next_page = edit_user_path
    render :new_registrant
  end
  
  def start_online_registration
    @user = current_user
  end
  
  def edit_contacts
    @user = current_user
  end
  
  def edit
    @step = params[:step]
  end
  
  def edit_notifications
    @hide_alert = true
    @step = 1
  end
  def edit_notifications_2
    @hide_alert = true
    @step = 2
  end
  def edit_notifications_3
    @hide_alert = true
    @step = 3
  end
  def edit_notifications_4
    
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
      if params[:skip_address] == "true"
        redirect_to information_path and return
      end
      if params[:select_address] == "confirm"
        user.is_registered = true
      end
      user.update_attributes!(user_params)
      if !params[:next_page].blank?
        redirect_to action: :edit and return
      end
      if params[:step]
        if params[:step].to_s == "0"
          redirect_to action: :edit_notifications and return 
        elsif params[:step].to_s == "1"
          redirect_to action: :edit_notifications_2 and return 
        elsif  params[:step].to_s == "2"
          redirect_to action: :edit_notifications_3 and return 
        elsif  params[:step].to_s == "3"
          redirect_to action: :edit_notifications_4 and return 
        else
          redirect_to params[:step] and return
        end         
      end
      
      redirect_to action: :show
    end
  end
  
  def confirm_registration
    current_user.update_attributes(confirmed_registration: true)
    redirect_to edit_notifications_user_path
  end
  
  private
  def user_params
    params.require(:user).permit([:first_name, :last_name, :middle_name, :dob_day, :dob_month, :dob_year, :address1, :address2, :address3, :postal_code, :email, :phone, :confirmed_registration, :global_preference, :global_receive_email] + (User.notification_types) + User.notification_types.collect{|t| t.gsub(/_notifications$/,"_notification_options")})
  end
  
end
