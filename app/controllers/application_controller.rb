class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def hello
    render html: "hello world!"
  end

  private
  
    def require_login
      unless current_user
        redirect_to signin_path
      end
    end
end
