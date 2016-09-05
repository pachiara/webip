class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :token_authenticatable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, password_length: 8..25

  validate  :email_domain

  def email_domain
    if !WEBIP['users_email_domain_validation_regex'].nil?
      r = Regexp.new(WEBIP['users_email_domain_validation_regex'])
      if (r =~ email).nil?
        errors.add(:email, :invalid_domain)
      end
    end
  end

end
