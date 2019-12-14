RailsAdmin.config do |config|

  ### Popular gems
  #
  # #TODO full name
  RailsAdmin.config {|c| c. label_methods << 'first_name'}

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ## == CancanCan ==
   config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true
  #
  #TODO exclude fields
  #config.model 'User' do
  #  #Reset password sent at
  #  list do
  #    field :name
  #    field :created_at
  #  end
  #end

  #TODO values
  #config.model 'Loan' do
  #  list do
  #    field :custom_column
  #  end
  #  #create do
  #  #  field :custom_list
  #  #end
  #end
  config.label_methods.unshift(:loan_name)


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
end
