class Email
  include ActiveModel::Validations
  include ActiveModel::Conversion  
  extend ActiveModel::Naming

  attr_accessor :id, :text, :recipient, :subject, :sender
 
  validates_presence_of :recipient, :subject, :text
  validates_format_of :recipient, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i  
  validates_length_of :text, :maximum => 500
  
  def initialize(attributes = {})
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @attributes = attributes
  end 
 
  def read_attribute_for_validation(key)
    @attributes[key]
  end
 
  def to_key
  end
  
  def to_model
    self
  end
  
  def persisted?  
    false  
  end
     
end
