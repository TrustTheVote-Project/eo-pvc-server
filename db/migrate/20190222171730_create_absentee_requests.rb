class CreateAbsenteeRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :absentee_requests do |t|
      t.string :street_number
      t.string :street_name
      t.string :street_unit
      t.string :city
      t.string :postal_code
      t.string :email
      t.string :gender
      
      t.boolean :do_not_share_permanent
      t.boolean :do_not_share_national
      t.boolean :do_not_share_municipal
      
      t.date :left_ontario
      t.date :intened_return_ontario
      t.boolean :intened_to_return
      t.boolean :example_two_year_limit_military
      t.boolean :example_two_year_limit_government
      t.boolean :example_two_year_limit_student
      t.boolean :example_two_year_limit_family
      
      t.string :delivery_option
      
      
      t.timestamps
    end
  end
end
