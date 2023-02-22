class EventMailer < ApplicationMailer
    
  def send_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]
    
    @mail = EventMailer.new()
    mail(
      from: ENV['MAIL_ADDRESS'],
      to:   member.email,
      subject: 'New Event Notice!!'
    )
  end
  
  def self.send_notifications_to_group(event)
    group = event[:group]
    group.users.each do |member|
      # deliver_nowとdeliver_laterの２種類のメール送信メソッドがあります。
      # deliver_nowは、今すぐに送信したい場合に使用します。
      # deliver_laterは、非同期で送信したい場合に使用します。
      EventMailer.send_notification(member, event).deliver_now
    end
  end
  
end
