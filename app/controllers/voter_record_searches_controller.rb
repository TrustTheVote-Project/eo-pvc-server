class VoterRecordSearchesController < ApplicationController
  
  def index
    @user = User.new
    @intro_paragraph = "Welome ... Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque sit amet felis turpis. Praesent ac massa nec enim vulputate convallis. In venenatis sed sapien sed auctor."
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
        @intro_paragraph = "Sorry, we did not find a record with locator #{s[:record_locator]}. You can re-enter another record locator, or check the box below to continue without a record locator."
        @user = User.new
        render action: :index 
        return
      end
    end
    if voter_record.nil?
      if s[:dob_year].blank? || s[:dob_month].blank? || s[:dob_day].blank?
        flash[:error] = "Please provide a valid date of birth"
        redirect_to action: :index 
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
  
end
