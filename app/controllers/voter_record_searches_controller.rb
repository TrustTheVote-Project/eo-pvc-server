class VoterRecordSearchesController < ApplicationController
  
  def index
  end
  
  def create
    s = params[:user] || params
    s = s.permit(:first_name, :last_name, :dob_day, :dob_month, :dob_year, :postal_code, :record_locator)
    voter_record = nil
    if s[:record_locator]
      voter_record = VoterRecord.where(record_locator: s[:record_locator]).first
    end
    if voter_record.nil?
      dob = Date.parse "#{s[:dob_year]}-#{s[:dob_month]}-#{s[:dob_day]}"
      voter_record = VoterRecord.where(first_name: s[:first_name], last_name: s[:last_name], dob: dob, postal_code: s[:postal_code]).first
    end  

    user = nil
    if voter_record
      user = User.new(s)
      user.password = user.password_confirmation = SecureRandom.hex(6)
      user.demo_id = SecureRandom.hex(3)
      user.save!
      # Create user from voter record, move on to confirmation, personalization
    else
      # Create user from params and start address search
    end
    
    respond_to do |format|
      format.html do
        sign_in(:user, user)
        redirect_to users_path
      end
    end
    
    
  end
  
end
