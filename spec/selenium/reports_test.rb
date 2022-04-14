# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to admin functions - click on site admin tab,
# filtering for different data columns

# selenium webdriver libraries
require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# custom library methods
require_relative "log_in.rb"
require_relative "filter.rb"

# Page-specific variables
$expected_title = 'View Malaria Reports'
$reports_url = 'malaria_reports/view'
$headings = ['Report Date', 'Reporter', 'Latitude', 'Longitude']

describe "QA admin user functions" do
  before(:all) { set_up_web_driver }

  # checks if admin tab works first
  context "checks site tabs" do
    it "navigates to reports tab" do
      click_nav_tab($reports_url)
      expect(page_title()).to eql($expected_title)
    end
  end

  # Checks different column's filtering functions
  context "checks filtering functions" do
    values = ['0', '1', '2', '3'] # Check four columns

    values.each do |col|
      it "attempts filter" do
        # navs to the site admin tab
        @driver.get "http://localhost:3000/malaria_reports/view"
        # get first row entry element
        entry = filter_empty(@driver, col)
        expect(entry.text).to eql($headings[col.to_i])
      end
    end
  end

  after(:all) do
    @driver.close
  end
end

def filter_empty(driver, column)
  # attempts to filter based on preferred sorting, and returns first row element
  # finds specifc column to click and waits for sorting arrow
  column = column.to_s.to_i
  column_headers = driver.find_elements(css: "a[class='column-header']")
  driver.action.move_to(column_headers[column]).click.perform
  sleep(inspection_time = 1)

  # sort the column based on the passed parameter sort
  # default will be sort up
  if column != 0
    driver.find_element(css: '.fa.fa-angle-down').click
  end
  waitUntil(10, 'filter_up')

  # returns the first row element of the given column unless told not to
  # setting xpath to be the proper column
  str = '//table/tbody/tr/th['
  str.concat((column+1).to_s).concat("]")
  return driver.find_element(xpath: str)
end
