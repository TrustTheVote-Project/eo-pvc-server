class VoterRecordSearchesController < ApplicationController
    
  before_action :hide_menu
  
  def index
    @user = User.new
    @intro_paragraph = t('welcome.intro') 
  end
  
  def new
    @user = User.new
  end
  
  def create
    @intro_paragrpah = ''
    if params[:no_record_locator]
      @user = User.new
      render action: :new
      return
    end
    s = params[:user] || params
    s = s.permit(:first_name, :last_name, :dob_day, :dob_month, :dob_year, :postal_code, :record_locator)
    voter_record = nil
    if !s[:record_locator].blank?
      voter_record = VoterRecord.where(record_locator: s[:record_locator]).first
      if voter_record.nil?
        @intro_paragraph = t('welcome.not_found', locator: s[:record_locator])
        @user = User.new
        render action: :index 
        return
      end
    elsif s[:record_locator] == ""
      flash[:error] = t('welcome.error.empty_record_locator')
      redirect_to action: :index 
      return
    end
    if voter_record.nil?
      @user = User.new
      @user.attributes = s.permit(:first_name, :last_name, :dob_day, :dob_month, :dob_year, :postal_code, :record_locator)
      if s[:first_name].blank? || s[:last_name].blank?
        flash[:error] = t('welcome.error.name')
      end
      if s[:dob_year].blank? || s[:dob_month].blank? || s[:dob_day].blank?
        flash[:error] = flash[:error] ? flash[:error] + "<br/>" : ""
        flash[:error] += t('welcome.error.dob')
      end
      if !(s[:postal_code].gsub(/\s+/,'') =~ /^[a-zA-Z]\d[a-zA-Z]\d[a-zA-Z]\d$/)
        flash[:error] = flash[:error] ? flash[:error] + "<br/>" : ""
        flash[:error] += t('welcome.error.postal_code_format')
      end
      if !flash[:error].blank?
        render action: :new 
        return
      end
      dob = Date.parse "#{s[:dob_year]}-#{s[:dob_month]}-#{s[:dob_day]}"
      voter_record = VoterRecord.where(first_name: s[:first_name], last_name: s[:last_name], dob: dob, postal_code: s[:postal_code]).first
    end  

    @user = User.new(s)
    @user.password = @user.password_confirmation = SecureRandom.hex(6)
    @user.demo_id = SecureRandom.hex(3)
    if voter_record
      @user.update_from_voter_record(voter_record)
    end
    @user.save!
    
    respond_to do |format|
      format.html do
        sign_in(:user, @user)
        redirect_to user_path
      end
    end
    
    
  end
  private
  def hide_menu
    @hide_menu = true
  end
end
