# frozen_string_literal: true

class User < ApplicationRecord
  enum role: {
    super_admin: 1,
    admin: 2,
    user: 3
  }, _default: :user

  attribute :activated, :boolean, default: false

  has_many :bookings, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :favorite_field_types, dependent: :destroy
  has_many :fields, dependent: :destroy

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

  scope :with_revenue_report, lambda {
    joins(fields: { field_types: { bookings: :price } })
      .where(bookings: { status: :confirmed })
      .select("users.id, users.email, SUM(prices.price) AS total_amount")
      .group("users.id")
  }

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

  def self.delete_inactive_expired_accounts
    User.where(activated: false).where("created_at >?", Settings.NUMBER_THRESHOLD.hours.ago).delete_all
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
