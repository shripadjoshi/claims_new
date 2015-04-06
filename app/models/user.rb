class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  validates :user_name, presence: true, uniqueness: {
    :case_sensitive => false
  }
  attr_accessor :login

  before_create :assign_role

  #scope :include_user_roles, include: [:roles]

  scope :include_user_roles, -> {
    includes("roles")
  }

  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(user_name) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_hash).first
    end
  end

  def user_roles
    #return self.roles.first.name.capitalize
    #return self.roles.collect(&:name).join(", ")
    return roles.collect{|role| role.name.capitalize}.join(", ")
  end
  
  def active_for_authentication?
    # Comment out the below debug statement to view the properties of the returned self model values.
    # logger.debug self.to_yaml
    super && active?
  end

  private

  def assign_role
    self.role_ids = Role.where(name: 'chemist').first.id
  end


end
