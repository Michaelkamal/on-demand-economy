RailsAdmin.config do |config|

  ### Popular gems integration

  # == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :admin
  end

  config.current_user_method(&:current_admin)

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
  config.excluded_models << Admin
  
    config.model 'Provider' do
      edit do
        field :url, :string
        field :name, :string
        field :rate, :integer
        field :image, :carrierwave , multipart: :true
        field :login_url, :string
        field :secret_key, :string
      end
    end
end
