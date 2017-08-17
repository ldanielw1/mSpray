class SessionsController < ApplicationController
  def create
    profile_img = request.env["omniauth.auth"]["extra"]["raw_info"]["picture"]
    profile_img.gsub!(/sz=50/, "sz=62")
    profile_img = nil if profile_img == "https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg?sz=62" # If there is no profile image

    # Set profile_img for the sidebar
    user = User.from_omniauth(request.env['omniauth.auth'])
    user.profile_img = profile_img
    user.save if user.changed?

    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
