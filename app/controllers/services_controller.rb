class ServicesController < ApplicationController
  
  before_action :set_user
  
  def index
  end
  
  def registration
    if current_user.is_registration_deadline_passed? 
      redirect_to register_same_day_services_path 
    else
      redirect_to register_online_services_path
    end
  end
  
  def register_online    
  end
  
  def register_same_day
    if (current_user.registration_submitted? && !current_user.is_registered?) || (current_user.reregistration_submitted? && !current_user.is_reregistered?)
      redirect_to register_same_day_2_services_path
    end
  end
  def register_same_day_2
  end
  
  def register_same_day_complete
    if current_user.is_registered?
      current_user.update_attributes({reregistration_submitted: true, is_reregistered: false})
    else
      current_user.update_attributes({registration_submitted: true})
    end
    @delivery = params[:same_day_delivery]
  end
  
  def by_mail
    if params[:select_type] == "special"
      redirect_to by_mail_special_ballot_services_path
    elsif params[:select_type] == "absentee"
      redirect_to absentee_requests_path
    end
  end
  
  # Request special ballot
  def by_mail_special_ballot
    if params[:delivery_option]
      current_user.is_special_ballot = true
      current_user.is_special_ballot_pending = true
      current_user.save(validate: false)
      @delivery = params[:delivery_option]
      render :by_mail_special_ballot_complete and return
    end
  end

  # Track special ballot status
  def by_mail_tracker
  end
  
  # Fill out online ballot to print and mail
  def online_special_ballot
    @selection = current_user.online_ballot_selection
  end
  
  def online_special_ballot_2
    if params[:contest_selection] || request.method.to_s.downcase == "post"
      current_user.update_attributes(online_ballot_selection: params[:contest_selection])
    elsif params[:write_in]
      current_user.update_attributes(online_ballot_selection: params[:write_in])
    end
    @selection = current_user.online_ballot_selection
  end
  
  def online_special_ballot_complete
    @delivery = params[:same_day_delivery] || "later"
  end
  
  # Sample ballot in-app
  def sample_ballot
    @selection = current_user.sample_ballot_selection
  end
  def sample_ballot_2
    if params[:contest_selection]  || request.method.to_s.downcase == "post"
      current_user.update_attributes(sample_ballot_selection: params[:contest_selection])
    end
    @selection = current_user.sample_ballot_selection
  end

  def dvic
    if current_user.dvic_retrieved
      redirect_to dvic_2_services_path and return
    end
  end
  
  def dvic_2
    current_user.update_attributes(dvic_retrieved: true)
    @qrcode = RQRCode::QRCode.new("https://eo-pvc.herokuapp.com/")
  end

  private
  def set_user
    @user = current_user
  end

  
end
