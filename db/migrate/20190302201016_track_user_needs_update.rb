class TrackUserNeedsUpdate < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :needs_reregistration, :string #nil, address, name, name_and_address
    add_column :users, :reregistration_submitted, :boolean
    add_column :users, :is_reregistered, :boolean
  end
end
