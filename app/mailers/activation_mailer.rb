class ActivationMailer < ApplicationMailer
  def activate(user)
    @user = user
    mail(to: @user.email, subject: 'Please activate your account')
  end
end
