class User < ActiveRecord::Base
  has_many :products
  has_many :orders

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } , :on => :create
  


  has_secure_password
  validates :password, length: { minimum: 6 }, :on => :create

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.find_user(user_id)
    return User.find(user_id)     
  end

  def self.findby_user(field, value)    
    query = field + " = ?"
    return User.where(query,value)     
  end
end
