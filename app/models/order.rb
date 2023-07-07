class Order < ActiveRecord::Base
  validates :sender_name, length: { minimum:3,  maximum:20 }
  validates :sender_phone, numericality: { only_integer: true }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :sender_email, presence: true, format: { with: VALID_EMAIL_REGEX }

  validates :source_location, presence: true, length: { maximum: 100 }

  validates :recipient_name, length: { minimum:3,  maximum:20 }
  validates :recipient_phone, numericality: { only_integer: true }
  validates :recipient_email, presence: true, format: { with: VALID_EMAIL_REGEX }

  validates :destination_location, presence: true, length: { maximum: 100 }

  validates :description, length: { maximum: 1000, too_long: "%{count} characters is the maximum allowed" }
end
