class AbsenteeRequestsController < ApplicationController
  def index
  end
  
  def new
    @absentee_request = AbsenteeRequest.new
  end
  
  def create
    @absentee_request = AbsenteeRequest.new(absentee_request_params)
    @absentee_request.user = current_user
    if @absentee_request.save
      redirect_to action: :step_2
    else
      render action: :new
    end
  end
  
  def step_2
  end
  
  def update    
  end
  
  private
  def absentee_request_params
    params.require(:absentee_request).permit(%w(street_number
      street_name
      street_unit
      city
      postal_code
      email
      gender
      do_not_share_permanent
      do_not_share_national
      do_not_share_municipal
      left_ontario
      intened_return_ontario
      intened_to_return
      example_two_year_limit_military
      example_two_year_limit_government
      example_two_year_limit_student
      example_two_year_limit_family
      delivery_option))
  end
end
