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
  
  def register_same_day_complete
  end
  
  def by_mail
  end
  
  def by_mail_absentee
  end
  def by_mail_special_ballot
  end

  private
  def set_user
    @user = current_user
  end
  
end
