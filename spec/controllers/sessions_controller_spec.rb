require 'rails_helper'

include WorkerHelper

RSpec.describe(SessionsController, type: :controller) do

  before(:each) do
    session["login_username"] = nil
    session["login_password"] = nil
    create_worker('1', 'Daniel', true)
  end

  describe 'When displaying the login page' do

    it 'is able to run pre-login page code without errors' do
      controller.send(:login)
    end

  end

end
