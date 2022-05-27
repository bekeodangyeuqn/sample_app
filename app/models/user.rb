class User < ApplicationRecord
  before_save{self.email = email.downcase}
  VALID_EMAIL_REGEX = Settings.validates.valid_email_regex

  validates :name, presence: true,
                   length: {maximum: Settings.validates.name_max_length}

  validates :email, presence: true,
                    length: {maximum: Settings.validates.email_max_length},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true,
                       length: {minimum: Settings.validates.password_min_length}

  has_secure_password
end
