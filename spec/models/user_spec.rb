require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    
    it "is a valid user with all valid fields present" do
      @user = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      expect(@user).to be_valid
    end

    it "is not a valid user without a password" do
      @user = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: nil)
      expect(@user).to_not be_valid
    end

    it "is not a valid user without a password_confirmation" do
      @user = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: nil)
      expect(@user).to be_valid
    end

    it "is not a valid user if password does not match password_confirmation" do
      @user = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "drowssap")
      expect(@user).to_not be_valid
    end

    it "is not a valid user if the email is not unique" do
      @user1 = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password:"password", password_confirmation:"password")
      @user2 = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      expect(@user2).to_not be_valid
    end

    it "is not a valid user without an email" do
      @user = User.create(firstname: "Brad", lastname: "Pitt", email: nil, password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "is not a valid user without a first name" do
      @user = User.create(firstname: nil, lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "is not a valid user without a last name" do
      @user = User.create(firstname: "Brad", lastname: nil, email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      expect(@user).to_not be_valid
    end

    it "is not a valid user if password is less than 3 characters" do
      @user = User.create(firstname: "Brad", lastname: nil, email: "bpitt@oscars.com", password: "12", password_confirmation: "12")
      expect(@user).to_not be_valid
    end
  end

  describe "authenticate_with_credentials" do
    
    it "should return an instance of the user if successfully authenticated" do
      @user1 = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      @user2 = User.authenticate_with_credentials(@user1.email, @user1.password)
      expect(@user2.firstname).to eq("Brad")
    end

    it "should return nil if a user is not successfully authenticated" do
      @user = User.authenticate_with_credentials("ryanreynolds@email.com", "password")
      expect(@user).to eq(nil)
    end

    it "is still a valid user if email contains spaces before or after" do
      @user1 = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password: "password", password_confirmation: "password")
      @user2 = User.authenticate_with_credentials("  bpitt@oscars.com  ", @user1.password)
      expect(@user2.firstname).to eq("Brad")
    end

    it 'is valid if email is without case sensitivity' do
      @user1 = User.create(firstname: "Brad", lastname: "Pitt", email: "bpitt@oscars.com", password:"password", password_confirmation:"password")
      @user2 = User.authenticate_with_credentials("bPiTt@OsCaRs.CoM", @user1.password)
      expect(@user2.firstname).to eq("Brad")
    end
  end
end