# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/welcome
  def welcome
    user = User.last
    # This is how you pass value to params[:user] inside mailer definition!
    UserMailer.with(user: user).welcome
  end

  def quittanceloyer
    loyer = Loyer.last
    LoyerMailer.with(loyer: loyer).create_quittance
  end

  def relance
    loyer = Loyer.last
    LoyerMailer.with(loyer: loyer).relance
  end

end
