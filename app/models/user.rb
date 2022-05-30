class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token
  before_save :downcase_email
  before_create :create_activation_digest

  VALID_EMAIL_REGEX = Settings.validates.valid_email_regex

  before_save{self.email = email.downcase}

  validates :name, presence: true,
                   length: {maximum: Settings.validates.name_max_length}

  validates :email, presence: true,
                    length: {maximum: Settings.validates.email_max_length},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true,
                       length: {minimum: Settings.validates.password_min_length}

  scope :by_recently_created, -> { order(created_at: :asc) }

  has_secure_password

  class << self
    # Returns the hash digest of the given string.
    def digest string
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated? attribute, token
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password? token
  end

  # Forgets a user.
  def forget
    update_attribute :remember_digest, nil
  end

  # Activates an account.
  def activate
    update_attribute :activated, true
    update_attribute :activated_at, Time.zone.now
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(:activation_token)
  end
end
