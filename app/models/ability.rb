class Ability
  include CanCan::Ability

  def initialize(user)
    can do |_action, subject_class, subject|
      check_resource(subject, subject_class, user)
    end
  end

  private

  def check_resource(subject, subject_class, user)
    resource = user_resource(subject, subject_class)
    user.permissions.where(resource:).any? do |permission|
      (permission.resource == resource.to_s)
    end
  end

  def user_resource(subject, subject_class)
    subject_class == Symbol ? subject : subject_class.name.underscore
  end
end
