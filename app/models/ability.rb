# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    case user.role
    when 'admin'
      can :access, :rails_admin
      can :manage, :dashboard
      can :manage, :all
      cannot :create, Payment
    when 'lender'
      can :access, :rails_admin
      can :manage, :dashboard
      can :read, Loan, lender_id: user.id
      can :read, Payment, loan: {id: user.lender_loans.map{|l| l.id}.flatten.uniq}
      can [:read, :show, :update], User, id: user.id
    when 'debtor'
      can :access, :rails_admin
      can :manage, :dashboard
      can :read, Loan, debtor_id: user.id
      can :read, Payment, loan: {id: user.debtor_loans.map{|l| l.id}.flatten.uniq}
      can [:read, :show, :update], User, id: user.id
    else
      cannot :access, :rails_admin
    end
  end
end
