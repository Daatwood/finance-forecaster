class Message < ActiveRecord::Base
  after_create :send_email

  validates_presence_of :to
  validates_presence_of :from
  validates_presence_of :subject

  def send_email
    user = User.find_by_email(to)
    unless user.blank?
      NotificationMailer.post_email(self).deliver
    end
  end
end
