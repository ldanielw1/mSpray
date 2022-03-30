# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to workers - click on tab, filter, reports

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# log in methods
require_relative "log_in.rb"

# expected end title
$expected_Title = 'Worker Data'
$expected_id = '10'
$expected_Header = 'Reports for Worker: Daniel (ID: 1)'

describe "automating mSpray QA" do
  it "checks workers tab" do
    @driver = set_up
    workers_tab
    expect(@driver.find_element(css: 'h1').text).to eql($expected_Title)
    @driver.quit
  end

  it "attempts filter" do
    @driver = set_up
    workers_tab
    filter_worker
    expect(@driver.find_element(xpath: '//table/tbody/tr[3]/td[1]').text).to eql($expected_id)
    @driver.quit
  end

  it "checks reports" do
    @driver = set_up
    workers_tab
    download_report
    expect(@driver.find_element(css: '.table.data-table').displayed?)
    @driver.quit
  end
end

def workers_tab
  # clicks on the worker info and reports tab on the side bar
  @driver.find_element(css: "a[href*='workers/view']").click
  waitUntil(10, 'worker')
end

def filter_worker
  # attempts to filter by name
  @driver.find_element(css: '.filter-view-button').click
end

def download_report
  # attempts to download a report
  # navs to report page
  @driver.find_element(css: '.btn.admin-button.blue.lighten-3').click

  #downloads a report
  @driver.find_element(css: '.btn.blue.lighten-3').click
  waitUntil(30, 'worker')
end
