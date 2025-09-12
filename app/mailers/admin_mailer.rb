class AdminMailer < ApplicationMailer
  default to: "sdorven@outlook.fr"

  def new_user_notification(user)
    @user = user
    mail(
      subject: "🆕 New User Registered: #{@user.email}",
      from: "samueldorven@outlook.fr" # remplace aussi si besoin
    )
  end
end
