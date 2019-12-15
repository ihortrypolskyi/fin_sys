RailsAdmin.config do |config|

  ### Popular gems
  #
  # #TODO full name
  RailsAdmin.config {|c| c. label_methods << 'full_name'}

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
  #TODO flash messages/ payment calculation / seed file
  config.model 'User' do
    list do
      field :id
      field :role
      field :email
      field :full_name
      field :created_at
    end

    create do
      field :email
      field :password
      field :first_name
      field :last_name
      field :role
    end

    edit do
      field :email
      field :password
      field :first_name
      field :last_name
      field :role
    end

    show do
      exclude_fields :lenders, :debtors, :full_name
    end
  end

  config.model 'Loan' do
    list do
      field :id
      field :sum
      field :percentage
      field :lender_name
      field :debtor_name
      field :debtor_name
      field :paid_back_sum
    end
  end

  config.model 'Payment' do
    list do
      exclude_fields :description , :updated_at, :created_at
    end
  end

  #config.label_methods.unshift(:loan_name)


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
