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
# expected end title
$expected_Title = 'View Malaria Reports'

# tab url
$reports_url = 'malaria_reports/view'

# table headings
$headings = ['Report Date', 'Reporter', 'Latitude', 'Longitude']

describe "QA admin user functions" do
  # setting up driver for testing environment
  before(:all) do
    @driver = set_up
  end

  # checks if admin tab works first
  context "checks site tabs" do
    it "navigates to reports tab" do
      # attempts to navigate to the malaria reports tab and gets the title element
      title_el = go_tab($reports_url)
      expect(title_el.text).to eql($expected_Title)
    end
  end

  # checks different column's filtering functions
  context "checks filtering functions" do
    # four columns to check
    values = ['0', '1', '2', '3']

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
