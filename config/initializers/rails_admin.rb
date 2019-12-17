RailsAdmin.config do |config|

  ### Popular gems

  RailsAdmin.config {|c| c. label_methods << 'full_name'}

  ## == Devise ==
   config.authenticate_with do
     warden.authenticate! scope: :user
   end
   config.current_user_method(&:current_user)

  ## == CancanCan ==
   config.authorize_with :cancancan

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

      include_fields :first_name, :last_name, :role do
        read_only do
          bindings[:object].role != 'admin'
        end
      end

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

    create do
      include_all_fields
      exclude_fields :lender, :debtor, :payments, :static_return_value, :pay_sum

      field :lender do
        associated_collection_cache_all false
        associated_collection_scope do
        Proc.new { |scope|
          scope.where(role: 'lender')
        }
        end
      end

      field :debtor do
        associated_collection_cache_all false
        associated_collection_scope do
          Proc.new { |scope|
            scope.where(role: 'debtor')
          }
        end
      end
    end

    edit do
      include_all_fields
      exclude_fields :lender, :debtor, :payments, :static_return_value, :pay_sum

      field :lender do
        associated_collection_cache_all false
        associated_collection_scope do
          Proc.new { |scope|
            scope.where(role: 'lender')
          }
        end
      end

      field :debtor do
        associated_collection_cache_all false
        associated_collection_scope do
          Proc.new { |scope|
            scope.where(role: 'debtor')
          }
        end
      end
    end
  end

  config.model 'Payment' do
    list do
      exclude_fields :description , :updated_at, :created_at
    end
  end

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

  end
end
