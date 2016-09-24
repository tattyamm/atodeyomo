module Common
  extend ActiveSupport::Concern

  #TODO 外部から色々指定する
  # メール送信
  def send_mail
    from = Email.new(email: ENV['MY_MAIL_FROM'])
    subject = 'test mail!'
    to = Email.new(email: ENV['MY_MAIL_TO'])
#    content = Content.new(type: 'text/plain', value: 'Hello, Email!')
#    content = Content.new(type: 'text/html', value: '<html><head></head><body>Hello, <br><b>Email!</b></body></html>')
    content = Content.new(type: 'text/html', value: 'Hello, <br><b>Email!</b>')
    mail = Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

end
