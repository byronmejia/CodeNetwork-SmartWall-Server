require 'bcrypt'

# Defines the Administrator User, used for the 
# Young Stater's control dashboard. 
# It is a totally different user type, not related
# to the 'unverified_user' and other classes.
class User
  include Mongoid::Document

  field :email, type: String
  field :password_hash, type: String
  field :user_name, type: String

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # Sets the user's password as a
  # BCrypt generated hash of the
  # string passed as parameter.
  #
  # @param [#new_pwd] The string to be hashed
  def password=(new_pwd)
    self.password_hash = BCrypt::Password.create(new_pwd)
  end

  # Alias to the hashed password.
  # If it's ever needed, it matches
  # the setter
  #
  # @returns [String] The password's hash
  def password
    password_hash
  end

  # Verifies the authenticity of the 
  # attempted password based on the
  # stored hash of the user's password.
  #
  # @param [#attempt] The tentative password;
  # @returns [Boolean] Whether or not the attempt
  #                    matches the actual password
  def authenticate?(attempt)
    BCrypt::Password.new(password_hash) == attempt
  end

end
