class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one :profile, dependent: :destroy
  after_create :init_profile

  has_many :orders

  #validates :username, uniqueness: { case_sensitive: false }
  # username validations
  validates_presence_of :username
  validates_uniqueness_of :username, :case_sensitive => false
  validates :username, :length => { :in => 5..20}


  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }

  # password validations
  validate :password_lower_case
  validate :password_uppercase
  validate :password_special_char
  validate :password_contains_number
  validates_length_of :password, :in => 6..20, :on => :create  # between 6 and 16 characters

  def password_uppercase
    return if !!password.match(/\p{Upper}/)
    errors.add :password, ' must contain at least 1 uppercase '
  end

  def password_lower_case
    return if !!password.match(/\p{Lower}/)
    errors.add :password, ' must contain at least 1 lowercase '
  end

  def password_special_char
    special = "?<>',?[]}{=-)(+-*&^%$@!`~{}!"
    regex = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    return if password =~ regex
    errors.add :password, ' must contain special character'
  end

  def password_contains_number
    return if password.count("0-9") > 0
    errors.add :password, ' must contain at least one number'
  end

  private
  def init_profile
    self.build_profile(username: self.username, email: self.email)
  end

end
