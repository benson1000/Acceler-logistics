class UserMailer < ApplicationRecord
  
  def reset_password_instructions(user)
    devise_mail(user, :reset_password_instructions)
  end

end


