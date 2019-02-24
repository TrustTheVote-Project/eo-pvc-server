require_relative '../../lib/rails_admin/config/fields/types/citext.rb'

RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.main_app_name = ["Elections Ontario: Personalized Voter Communication (PVC)", "Demonstration Console"]
  

  config.navigation_static_links = {
    'Demo Home' => '/demo_admin',
    'Guide' => '/demo_admin_guide.html'
  }

  config.authenticate_with do
    authenticate_or_request_with_http_basic('Demo Admin Login') do |username, password|
      username == 'demo' && password == 'elections-ontario'
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new do
      only ['Notification']
    end
    #export
    bulk_delete  do
      only ['Notification']
    end
    show
    edit do
      only ['User']
    end
    delete do
      only ['Notification', 'User']
    end

    #show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  
  
  
  config.model VoterRecord do
    label "Voter Record"
    weight 1
    
    
    list do
      field :id
      field :first_name
      field :last_name
      field :dob do
        label "Date Of Birth"
      end
      field "record_locator"
      field "registration_id" do
        label "Registration ID"
      end
      field "postal_code"
      field "address1"
      field "address2"
      field "address3"
      
    end
  end
  
  config.model User do
    weight 2
    
    object_label_method :demo_id
    list do
      field :id
      field :demo_id do
        label "Demo ID"
      end
      field :first_name
      field :last_name
      field :is_registered
      field :registration_id do
        label "Registration ID"
      end
    end
  end
  

  

  config.model Notification do
    weight 3
    list do
      field :id
      field :user
      field :notification_type
      field :created_at
      field :delivered
    end
    create do
      field :user
      field :notification_type
    end
  end
  
  
end
