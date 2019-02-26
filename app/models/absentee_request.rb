class AbsenteeRequest < ApplicationRecord
  
  belongs_to :user
  
  # validates_presence_of :street_number
  # validates_presence_of :street_name
  # validates_presence_of :city
  # validates_presence_of :postal_code
  # validates_presence_of :email
  # validates_presence_of :gender
  def mailing_address
    [[mailing_street_number, mailing_street_name, mailing_street_unit].join(" "),
     [mailing_city].join(", "),
     [mailing_postal_code].join(', ')].join("<br/>")
  end
  
end
