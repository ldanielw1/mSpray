# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to admin functions - click on site admin tab,
# filtering for different data columns

# selenium webdriver libraries
require "selenium-webdriver"
require "rspec"

# custom library methods
require_relative "log_in.rb"
require_relative "filter.rb"

# Test specifc elements
# admin url
$admin_url = '/admin/site_permissions'

# expected end title
$expected_Title = 'Site Permissions'

# expected names
$expected_name = 'MSpray App'
$expected_email = 'msprayapptest@gmail.com'
$expected_admin = ' admin '

describe "QA admin user functions" do
  # setting up driver for testing environment
  before(:all) do
    @driver = set_up
  end

  # checks if admin tab works first
  context "checks site tabs" do
    it "navigates to admin tab" do
      # attempts to navigate to the site admin tab and gets the title element
      title_el = go_tab($admin_url)
      expect(title_el.text).to eql($expected_Title)
    end
  end

  # checks if admin functions works
  context "checks user editing" do
    before(:each) do
      # navigates to site admin tab
      @driver.get "http://localhost:3000/admin/site_permissions"
    end

    it "clicks on edit" do
      # attempts to click on edit
      expect(click_button(@driver, 'edit'))
    end

    it "edits user info" do
      # attempts to edit the user info
      click_button(@driver, 'edit')
      expect(edit_user)
    end

    it "clicks on delete" do
      # attempts to click on delete
      expect(click_button(@driver, 'delete'))
    end

    it "deletes user" do
      # attempts to delete user
      click_button(@driver, 'delete')
      expect(delete_user)
    end
  end

  # checks different column's filtering functions
  context "checks filtering functions" do
    # three columns to check
    values = {'0':$expected_name, '1':$expected_email, '2':$expected_admin}

    values.each do |col, expected|
      it "attempts filter" do
        # navs to the site admin tab
        @driver.get "http://localhost:3000/admin/site_permissions"
        # get first row entry element
        entry = filter(@driver, col, 'up')
        expect(entry.text).to eql(expected)
      end
    end
  end

  after(:all) do
    @driver.close
  end
end

def edit_user
  # attempts to edit user name
  # not functional at the moment
  return (filter(@driver, '0', 'down').text == $expected_name)
end

def delete_user
  # attempts to delete user
  #finds initial number of rows
  init_rows = num_rows(@driver)

  # not functional at the moment

  # returns expectation that init != after
  return (init_rows != num_rows(@driver))
end
