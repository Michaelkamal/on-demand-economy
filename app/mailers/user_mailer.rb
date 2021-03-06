class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.registeration_confirmation.subject
  #
  def registeration_confirmation(user)
    @user=user
    mail to: @user.email, subject: "Driveo Registeration" 
  end


  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.forgot_password.subject
  #
  def forgot_password(user,reset_token)
    @user=user
    @reset_token=reset_token
    @mob_url="Driveo://driveo.herokuapp.com/api/v1/authentication/resetpassword?hash=#{@reset_token}"
    @url="https://driveo.herokuapp.com/api/v1/authentication/mobile/resetpassword?hash=#{@reset_token}"

    mail to: @user.email, subject: "Driveo Reset Password"
  end
end
