class Contact < ActiveRecord::Base
  validates :firstName, length: { minimum:3,  maximum:20 }
  validates :lastName,  length: { minimum:3, maximum:20 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false, message: "Email MUST be Unique." }
  validates :phoneNumber, numericality: { only_integer: true }
  validates :comment, presence: true, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
  validates_uniqueness_of :email, on: :create, message: "must be unique"
end
