# frozen_string_literal: true

# app/mailers/password_mailer.rb
class PasswordMailer < ApplicationMailer
  def reset_password_email
    @user = params[:user]
    @token = @user.send(:set_reset_password_token, Time.now)

    mail(to: @user.email, subject: 'Reset your password') do |format|
      format.text { render plain: "To reset your password, click the link: #{edit_password_url(@user, reset_password_token: @token)}" }
    end
  end
end
