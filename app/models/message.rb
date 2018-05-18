class Message
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :email, :subject, :content

  validates_presence_of :name, :email, :subject, :content

  validates_format_of :email, :with => %r{.+@.+\..+}

  def initialize(attributes = {})
    return super() unless attributes

    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

end
