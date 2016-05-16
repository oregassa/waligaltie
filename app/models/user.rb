class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments
  before_save {self.email = email.downcase}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 50},
	           uniqueness: {case_sensitive: false},
	           format: {with: VALID_EMAIL_REGEX}
  validates :username, presence: true, length: {minimum: 3, maximum: 12}

  def login=(login)
    @login = login
  end

  def login
  	@login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
      elsif conditions.has_key?(:username) || conditions.has_key?(:email)
        where(conditions.to_hash).first
      end
    end
end
