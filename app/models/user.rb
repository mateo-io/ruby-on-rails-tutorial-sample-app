class User < ActiveRecord::Base
	attr_accessor :remember_token, :activation_token

	#Attribute validation
	before_create :create_activation_digest #Activation digest for email activation
	before_save :downcase_email
	validates :name, presence: true, length: { maximum: 50}
	
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255},
		format: { with: VALID_EMAIL_REGEX },
		uniqueness: { case_sensitive: false}

	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

	
	
	
	#ClASS METHODS
	class << self
	# Returns the hash digest of the given string.
		def digest(string)
			cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
			                                              BCrypt::Engine.cost
			BCrypt::Password.create(string, cost: cost)
		end

		#Returns a random token
		def new_token
			SecureRandom.urlsafe_base64
		end
	end


	#Session Remembering Methods
	def remember
		self.remember_token = User.new_token
		update_attribute(:remember_digest, User.digest(remember_token))
	end

	#Returns true if the given token matches the digest.
	def authenticated?(attribute, token)
	   digest = send("#{attribute}_digest")
	   return false if digest.nil?
	   BCrypt::Password.new(digest).is_password?(token)
	end

	def forget
		update_attribute(:remember_digest, nil)
	end
	#End session methods

	#Activation methods
	def activate
		update_attribute(:activated, true)
		update_attribute(:activated_at, Time.zone.now)
	end

	#Activation email
	def send_activation_email
		UserMailer.account_activation(self).deliver_now
	end

private
	def create_activation_digest
		self.activation_token=User.new_token
		self.activation_digest=User.digest(activation_token)
	end

	def downcase_email
		self.email=email.downcase
	end

end
