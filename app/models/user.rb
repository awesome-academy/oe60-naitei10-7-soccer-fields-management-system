# frozen_string_literal: true

class User < ApplicationRecord
  has_many :bookings
  has_many :comments
  has_many :reviews

  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :phone_number, presence: true
  validates :password, presence: true
  validates_confirmation_of :password_digest
  validate :password_requirements_are_met
  attr_accessor :activation_token

  before_create :create_activation_digest

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def send_cancel_booking_success_email
    UserMailer.cancel_booking_success.deliver_now
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def active
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def authenticated?(attribute, token)
    digest_num = send("#{attribute}_digest")
    return false unless digest_num.present?

    bcrypt_password = BCrypt::Password.new digest_num
    bcrypt_password === token
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  private

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = digest activation_token
  end

  def password_requirements_are_met
    return if password.match(/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,10}$/)

    errors.add(:password,
               I18n.t("errors.messages.invalid_password"))
  end

  def digest string
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, { cost: })
  end
end
