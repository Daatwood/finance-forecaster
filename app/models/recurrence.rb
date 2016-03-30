# Recurrence are due dates for bills. They allow themselves to represent a single date or multiple dates by repeating
# Eg. First bill is always higher. Add exception to the first due date of recurrence then add a one-time recurrence with adjusted amount.
class Recurrence < ActiveRecord::Base
  belongs_to :bill
  has_many :exclusions

  validates_presence_of :frequency

  def next_date
    active_at.to_date + advance_frequency
  end

  def forever?
    expires_at.blank? || active_at.to_date == expires_at.to_date
  end

  def basic_frequency
    case frequency
    when "DAILY"
      return (1).day
    when "WEEKLY"
      return (7).days
    when "MONTHLY"
      return (1).month
    when "YEARLY"
      return (1).year
    else
      return 0
    end
  end

  def advance_frequency
    case frequency
    when "DAILY"
      return (1 * interval).day
    when "WEEKLY"
      return (7 * interval).days
    when "MONTHLY"
      return (1 * interval).month
    when "YEARLY"
      return (1 * interval).year
    else
      return 0
    end
  end

  # def create_logical_payments(end_date=Time.now.to_date + 6.months)
  #   # Loop each recurrence
  #   logical_payments = []
  #   current_increment = interval
  #   current_date = active_at.to_date
  #   # Create 10 instances of recurrence
  #   until current_date > end_date do
  #     if current_increment % interval == 0
  #       # create logical payment
  #       #puts "Logical::Payment, #{current_date} $#{amount}"
  #       amt = bill.expense? ? -amount : amount
  #       logical_payments << Logical::Payment.new(current_date,bill.bank,bill.bank.balance,amt,note,bill)
  #     end
  #
  #     advancement = basic_frequency
  #     if advancement == 0
  #       return logical_payments
  #     end
  #     current_date += advancement
  #     current_increment += 1
  #     unless forever?
  #       return logical_payments if current_date > expires_at.to_date
  #     end
  #   end
  #   logical_payments
  # end

end
