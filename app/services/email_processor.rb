class EmailProcessor
  def initialize(email)
    @email = email
  end

  def process
    # all of your application-specific code here - creating models,
    # processing reports, etc

    # here's an example of model creation
    puts "EMAIL :::: TO:#{@email.from[:email]}, SUBJECT:#{@email.subject}, BODY:#{@email.body}"
    
    puts "EMAIL :::: ALL: #{@email.inspect}"
    #@email.inspect
    #   user = User.find_by_email(@email.from[:email])
    #   user.posts.create!(
    #     subject: @email.subject,
    #     body: @email.body
    #   )
  end
end
