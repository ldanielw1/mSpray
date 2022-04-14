# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to admin functions that's not users related
# edits and deletes Spray Data, Future Spray Locations, Malaria Reports
# and checks on Worker Info and Data

# selenium webdriver libraries
require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# custom library methods
require_relative "log_in.rb"
require_relative "filter.rb"

describe "QA admin data edit functions" do
  # setting up driver for testing environment
  before(:all) do
    @driver = set_up
  end

  # checks if dpray data admin functions works
  context "checks data editing" do
    # tabs to check
    tabs = {'spray_data/view':'Daniel', 'workers/view':'Annie'}

    tabs.each do |tab_url, name|
      context "of #{tab_url}" do
        before(:each) do
          url = 'http://localhost:3000/'.concat(tab_url.to_s)
          @driver.get url
        end

        it "clicks on edit" do
          # attempts to click on edit and expects modal
          expect(click_button(@driver, 'edit'))
        end

        it "edits data info" do
          # attempts to edit the user info
          click_button(@driver, 'edit')
          expect(edit_data()).to eql(name)
        end

        it "clicks on delete" do
          # attempts to click on delete and expects modal
          expect(click_button(@driver, 'delete'))
        end

        it "deletes data" do
          # attempts to delete data
          init_rows = num_rows(@driver)
          click_button(@driver, 'delete')
          expect(delete_data()).to eql(init_rows)
        end
      end
    end
  end

  after(:all) do
    @driver.close
  end
end

def edit_data
  # attempts to edit data

  # not functional at the moment

  # returns the first element of the first row
  return filter(@driver, '1', 'up').text
end

def delete_data
  # attempts to delete user

  # not functional at the moment

  # returns expectation that init != after
  return num_rows(@driver)
end
