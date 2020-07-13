require 'openssl'

class User < ApplicationRecord

  has_many :questions

  attr_accessor :password

  REGEX_USERNAME = /\A\w+\z/.freeze
  REGEX_EMAIL = /\A[\w+\-]+\@[\w+\-]+\.\w+\z/.freeze
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new

  before_validation :downcase_username, :downcase_email
  before_save :encrypt_password

  validates :email,
    presence: true,
    uniqueness: true,
    format: { with: REGEX_EMAIL },
    length: { maximum: 50 }

  validates :username,
    presence: true,
    uniqueness: true,
    format: { with: REGEX_USERNAME},
    length: { maximum: 30, minimum: 3}

  validates_presence_of :password, on: :create

  validates_confirmation_of :password

  def downcase_username
    self.username = username.downcase
  end

  def downcase_email
    self.email = email.downcase
  end

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(password, password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user.present? && user.password_hash == User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))
      user
    else
      nil
    end
  end

end
