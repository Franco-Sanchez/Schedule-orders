class OrderMailer < ApplicationMailer
  default from: 'francorsr98@gmail.com'

  def order_discarded_email
    @client = params[:client]
    mail(to: @client.email, subject: 'Response to your order')
  end
end
