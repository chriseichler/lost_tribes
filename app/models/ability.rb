class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities


    # IDK IF THIS SHIT WORKS YET
    @user ||= User.new # guest user (not logged in)
    @user.roles.each { |role| send(role) }

    if @user.roles.size == 0
      can :read, :all
    end
  end

  can :manage, :all if user.role == "admin"

  # def admin
  #   can :manage, :all
  # end

  # def vendor
  #   can :manage, Event, :active => true, :creator_id => @user.id
  # end

  # def customer
  #   can :read, :all
  # end

end
