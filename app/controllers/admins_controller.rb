require 'csv'

##
# Controller managing GTS actions related to views available to admins
class AdminsController < ApplicationController
  before_action :admin_only
  before_action { get_display_settings(:name) }
  attr_reader :users, :terms, :term_dropdown_contents, :name, :email

  ##
  # Show all of the Users with special privileges on the GTS app
  def site_permissions
    sort_hash = get_proper_sort_categories([:name, :email, :admin])
    @users = User.all.order(sort_hash)
  end

  ##
  # Change permissions of a user
  def change_permissions
    user = User.find(params[:user][:id])
    user.admin = params[:user][:admin]
    user.save!
    redirect_back(fallback_location: site_permissions_admin_path)
  end

  ##
  # Delete a user
  def delete_user
    user = User.find(params[:user][:id])
    user.destroy!
    redirect_back(fallback_location: site_permissions_admin_path)
  end

end
