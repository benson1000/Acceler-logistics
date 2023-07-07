class Users::RegistrationsController < Devise::RegistrationsController
  # GET /resource/sign_in
  def new
    super
  end

  ## custom sign-in code
  
  def create
    super
  end
end
