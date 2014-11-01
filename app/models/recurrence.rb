class Recurrence < ActiveRecord::Base
  belongs_to :bill

  validates_presence_of :frequency

  # Recurrence are due dates for bills. They allow themselves to represent a single date or multiple dates by repeating
  # Eg. First bill is always higher. Add exception to the first due date of recurrence then add a one-time recurrence with adjusted amount.


  def create_logical_payments
    # Loop each recurrence
    logical_payments = []
    current_increment = interval
    current_date = active_at.to_date
    # Create 10 instances of recurrence
    (1..10).each do |i|
      if current_increment % interval == 0
        # Do additional check to make sure the current_date isnt an exception date.

        # create logical payment
        #puts "Logical::Payment, #{current_date} $#{amount}"
        logical_payments << Logical::Payment.new(self,amount,current_date)
      end
      current_increment += 1
      current_date += advance_frequency(frequency)
    end
    logical_payments
  end

  def advance_frequency(freq)
    case freq
    when "DAILY"
      return 1.day
    when "WEEKLY"
      return 7.days
    when "MONTHLY"
      return 1.month
    when "YEARLY"
      return 1.year
    else
      puts "Unknown advancement"
      return 1.day
    end
  end
end
