class User < ActiveRecord::Base
  EMAIL_REGEX = /@/ # Some fancy email regex


  validates :full_name, presence: true
  validates :email, presence: true, format: EMAIL_REGEX
  validates :password, presence: true, confirmation: true
end