class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    case user
    when Student
      can :create, ScRelationship
      can :read, :all
    when Administrator
      if user.admin?
        can :manage, :all
      else
        can :create, AdminAnnouncement
        can :update, AdminAnnouncement do |admin_announcements|
          admin_announcements.user = user
        end
        can :destroy, AdminAnnouncement do |admin_announcements|
          admin_announcements.user = user
        end
        can :manage, :school
        
      end
    when Teacher
      
      can :update, AdminAnnouncement do |admin_announcements|
          admin_announcements.user = user
      end
        
      can :update, AdminAnnouncement do |admin_announcements|
        admin_announcements.user = user
      end
      
      
      
    end
  end
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
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
end
