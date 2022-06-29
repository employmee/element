class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  # include pundit

  # after_action :verify_authorized, except: :index, unless: :skip_pundit?
  # after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    # For additional fields in app/views/devise/registrations/new.html.erb
    devise_parameter_sanitizer.permit(:sign_up, keys: [:role])

    # For additional in app/views/devise/registrations/edit.html.erb
    devise_parameter_sanitizer.permit(:account_update, keys: [:role, :first_name, :last_name, :location, :description, :phone_number, :experience, :photo])
  end

  def after_sign_up_path_for(resource)
    if current_user.role == "Teacher"
      edit_user_registration_path
    else
      "/"
    end
  end

  def after_sign_in_path_for(resource)
    if current_user.role == "Teacher"
      if current_user.first_name.present?
        subjects_path
      else
        edit_user_registration_path
      end
    else
      "/"
    end
  end
end
