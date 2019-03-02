class AddUserRegistrationDeadlinePassed < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :is_registration_deadline_passed, :boolean
  end
end
