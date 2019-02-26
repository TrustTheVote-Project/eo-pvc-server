class ServicesController < ApplicationController
  
  before_action :set_user
  
  def index
  end
  
  def registration
  end
  
  def register_online    
  end
  
  def register_same_day
  end
  def register_same_day_2
  end
  
  def register_same_day_complete
  end
  
  def by_mail
  end
  
  # Request special ballot
  def by_mail_special_ballot
  end

  # Track special ballot status
  def by_mail_tracker
  end
  
  # Fill out online ballot to print and mail
  def online_special_ballot
  end
  
  def online_special_ballot_2
    @selection = params[:contest_selection]
    @write_in = params[:write_in]
  end
  
  # Sample ballot in-app
  def sample_ballot
  end

  def dvic
  end

  private
  def set_user
    @user = current_user
  end

  
end
