class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    message = Message.new
    message.to = 'atwood.dustin@gmail.com'
    message.from = @email.from[:email]
    message.subject = @email.subject
    message.body = @email.body

    puts "EMAIL :::: TO:#{@email.to}"

  end
end
