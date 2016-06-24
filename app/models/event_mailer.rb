class EventMailer < ActionMailer::Base

  def announce(sent_at = Time.now)
    @subject    = '[Eta Phi] #{@reminder.event.title}'
    @from       = @reminder.user.email
    @sent_on    = sent_at
    @headers    = {}
  end
end