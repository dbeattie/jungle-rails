class User < ActiveRecord::Base
    has_secure_password

    validates :firstname, presence: true
    validates :lastname, presence: true
    validates :email, presence: true
    validates :email, uniqueness: { case_sensitive: false },
                        on: :create
    validates :password, presence: true
    validates :password, confirmation: true,
                            length: { minimum: 3 },
                            on: :create

    def self.authenticate_with_credentials(email, password)
        user = User.where("lower(email) = ?", email.strip.downcase).first
        if user && user.authenticate(password)
        return user
        else
        return nil
        end
    end
end
