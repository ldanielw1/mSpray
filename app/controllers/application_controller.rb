class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user
  before_action :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  private

  ##
  # Ensures that only admins can view the current page
  def admin_only
    unless current_user.admin?
      redirect_back(fallback_location: root_path)
    end
  end

  ##
  # Force users to login if nobody is logged in via the session hash right now
  def require_login
    unless current_user
      redirect_to signin_path
    end
  end

  ##
  # Sets controller variables related to sorting and filtering for all views
  def get_display_settings(default_sort)
    @sort = params.has_key?(:sort) ? params[:sort].to_sym : default_sort
    @sort = :start_date if @sort == :term
    @reverse = params.has_key?(:reverse) && params[:reverse] == "true"

    @filters = Hash.new
    params[:filter].each { |key, value| @filters[key] = value } if params.has_key?(:filter)
  end

  ##
  # Sets controller variables related to sorting for all views
  def get_proper_sort_categories(default_sort_categories)
    sort_hash = Hash.new
    default_sort_categories.delete(@sort)
    default_sort_categories.insert(0, @sort) if not @sort.nil?
    default_sort_categories.each_with_index do |sort, index|
      direction = :asc
      if index == 0
        direction = @reverse ? :desc : :asc
      end
      sort_hash[sort] = direction
    end
    return sort_hash
  end

  helper_method :current_user
end
