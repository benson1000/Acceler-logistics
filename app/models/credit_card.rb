class CreditCard < ApplicationRecord

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :card_number, presence: true, format: { with: /\A\d{12,19}\z/, message: "should be a valid credit card number" }
  validates :expiry_date, presence: true
  validates :cvv, presence: true, numericality: { only_integer: true }, length: { minimum: 3, maximum: 4 }

  validate :valid_expiry_date

  def valid_expiry_date
    if expiry_date.present? && expiry_date < Date.today + 2.days
      errors.add(:expiry_date, "must be at least 2 days from today")
    end
  end

end
