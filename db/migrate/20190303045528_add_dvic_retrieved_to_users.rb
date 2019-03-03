class AddDvicRetrievedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :dvic_retrieved, :boolean
  end
end
