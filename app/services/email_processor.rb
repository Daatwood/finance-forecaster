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
    message.save

    puts "EMAIL :::: TO:#{@email.to.first[:email]}"
    puts "EMAIL :::: TO:#{@email.to.class}"
  end
end
