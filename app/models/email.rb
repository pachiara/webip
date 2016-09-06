class Email
  include ActiveModel::Model

  attr_accessor :id, :text, :recipient, :subject, :sender, :cc

  #validates_presence_of :recipient, :subject
  #validates :text, presence: true, length: {in:2..255}
  #validates_format_of :recipient, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  validate :check_email_addresses

  def check_email_addresses
    recipient.split(/,\s*/).each do |email|
      unless email =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
        errors.add(:recipient, "formato email invalido: #{email}")
      end
    end
  end


end
