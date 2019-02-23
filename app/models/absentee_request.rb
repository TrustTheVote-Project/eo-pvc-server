class AbsenteeRequest < ApplicationRecord
  
  belongs_to :user
  
  # validates_presence_of :street_number
  # validates_presence_of :street_name
  # validates_presence_of :city
  # validates_presence_of :postal_code
  # validates_presence_of :email
  # validates_presence_of :gender
  
end
