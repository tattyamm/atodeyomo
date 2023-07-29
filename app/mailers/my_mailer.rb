class MyMailer < ApplicationMailer

    default from: ENV['MAIL_FROM'], subject:'メールタイトルテスト'
    def send_mail(mail_title, mail_body)
        @message=mail_body
        mail to: ENV['MAIL_TO'], subject: mail_title
    end

end
