module Common
  extend ActiveSupport::Concern

  def send_mail(from_mail, from_to, subject, body)
    from = SendGrid::Email.new(email: from_mail)
    to = SendGrid::Email.new(email: from_to)
    content = Content.new(type: 'text/html', value: body)
    mail = SendGrid::Mail.new(from, subject, to, content)

    sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: mail.to_json)
    puts response.status_code
    puts response.body
    puts response.headers
  end

end
