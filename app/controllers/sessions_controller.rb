class SessionsController < ApplicationController
  skip_before_action :require_login

  def login
    redirect_to root_path if current_user
  end

  def create
    if id_token = flash[:google_sign_in]['id_token']
      user_params = GoogleSignIn::Identity.new(id_token)
      profile_img = user_params.avatar_url.strip.gsub(/s96-c$/, "s62-c")
      if (!User.exists?(user_id: user_params.user_id))
        new_user = User.new
        new_user.user_id = user_params.user_id
        new_user.name = user_params.name
        new_user.email = user_params.email_address
        new_user.profile_img = profile_img
        new_user.save!
      end

      user = User.find_by_user_id(user_params.user_id)
      if AllowedEmail.find_by_email(user.email).nil?
        flash[:error] = "#{user.email} is not an allowed email. Please log in with a valid account."
        redirect_to signin_path
      else
        # Set profile_img if updated
        user.profile_img = profile_img
        user.save if user.changed?
        cookies.signed[:user_id] = user_params.user_id
        redirect_to root_path
      end

    else
      flash[:error] = 'Google login failed - please try again'
      redirect_to signin_path
    end

  end

  def destroy
    cookies.delete(:user_id)
    redirect_to root_path
  end

end
