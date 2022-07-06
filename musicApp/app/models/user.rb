# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    validates :email, :password_digest, :session_token, presence: true
    before_validation :ensure_session_token

    attr_reader :password

    def self.find_by_credentials(email, password)
        @user = User.find_by(email: email) # we find it only by email because we do not have a password column
        return nil unless @user && user.is_password?(password) #if we find it, we call is_password and it has to match, otherwise return nil

    end



    def self.generate_session_token
        SecureRandom::urlsafe_base64  #Here we are generating the session_token
    end


    def reset_session_token!
        self.update!(session_token: self.class.generate_session_token) #update with a bang so we get an error if it fails.
        self.session_token
    end


    def ensure_session_token
        self.session_token ||= self.class.generate_session_token #If there isn't already one, we create it.
    end



    def password=(password)
        #I might have to create a @password = password if I want to put constraints on a password such as length
        @password=password
        self.password_digest = BCrypt::Password.create(password) #Here we create the password_digest which is just a string

    end


    def is_password?(password)
        bcrypt_password=BCrypt::Password.new(password_digest) #Here we make it into a BRcrypt object
        bcrypt_password.is_password?(password) #Here we compare if the outcome matches
    end




end
