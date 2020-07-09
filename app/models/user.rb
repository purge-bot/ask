require 'openssl'

class User < ApplicationRecord

	attr_accessor :password

	ITERATIONS = 20_000
	DIGEST = OpenSSL::Digest::SHA256.new

	has_many :questions

	before_validation :downcase_username, :downcase_email
	before_save :encrypt_password

	validates :email,
		presence: true,
		uniqueness: true
		length: { maximum: 50, minimum: 6}

	validates :username, 
		presence: true,
		uniqueness: true,
		# format: { with: /a-z/}, #Вставить регулярку
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