class Ability
    include CanCan::Ability

    def initialize(user)

      if user.nil?
        can :read, :all
      else
        can [:read, :create], :all
        puts :user_id
        can [:update, :destroy], Restaurant, :user_id => user.id
      end
    end
end
