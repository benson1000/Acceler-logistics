class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  # app/controllers/application_controller.rb

  def after_sign_in_path_for(resource)
    if resource.is_a?(User) # Individual user
      flash[:success] = "Welcome #{resource.username} to Speed Logistics. You can make an order, check your order status, view your order history, and cancel an order."
      new_order_path
    elsif resource.is_a?(Company) # Company user
      flash[:success] = "Welcome Home, #{resource.email}. You are logged in as a company."
      # Redirect to the company-specific path, e.g., company_dashboard_path or any other desired page.
      new_companies_order_path
    else
      super
    end
  end


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
end
