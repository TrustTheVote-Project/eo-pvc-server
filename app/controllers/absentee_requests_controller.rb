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
      redirect_to step_2_absentee_request_path(@absentee_request)
    else
      render action: :new
    end
  end
  
  def step_2
    @absentee_request = AbsenteeRequest.find(params[:id])
  end
  def step_3
    @absentee_request = AbsenteeRequest.find(params[:id])
  end
  def step_4
    @absentee_request = AbsenteeRequest.find(params[:id])
  end
  def complete
    @absentee_request = AbsenteeRequest.find(params[:id])
  end
  
  def update    
    @absentee_request = AbsenteeRequest.find(params[:id])
    if @absentee_request.save
      if params[:step] == "2"
        redirect_to step_3_absentee_request_path(@absentee_request)
      elsif params[:step] == "3"
        redirect_to step_4_absentee_request_path(@absentee_request)
      elsif params[:step] == "4"
        @absentee_request.submitted = true
        @absentee_request.save
        redirect_to complete_absentee_request_path(@absentee_request)
      end
      
    end
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
