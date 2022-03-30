# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to workers - click on tab, filter, reports

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# auth id and pass
$login_id = 'msprayapptest@gmail.com'
$login_pass = 'mSprayApp2.0'

# expected end title
$expected_Title = 'Worker Data'
$expected_id = '10'
$expected_Header = 'Reports for Worker: Daniel (ID: 1)'

describe "automating mSpray QA" do
  it "checks workers tab" do
    setup
    workers_tab
    expect(@driver.find_element(css: 'h1').text).to eql($expected_Title)
    @driver.quit
  end

  it "attempts filter" do
    setup
    workers_tab
    filter_worker
    expect(@driver.find_element(xpath: '//table/tbody/tr[3]/td[1]').text).to eql($expected_id)
    @driver.quit
  end

  it "checks reports" do
    setup
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

def setup
  # sets up selenium webdriver test environment
  @driver = Selenium::WebDriver.for :chrome
  hack_Google
  dismiss_notification
end

def waitUntil(time, element)
  # waits until a predefined element displayed
  wait = Selenium::WebDriver::Wait.new(timeout: time)

  # Google login id
  if element == 'login'
    wait.until { @driver.find_element(id: 'identifierId').displayed? }
  # Google login password
  elsif element == 'password'
    wait.until { @driver.find_element(id: 'password').displayed? }
  # mSpray map element
  elsif element == 'map'
    wait.until { @driver.find_element(css: '.fas.fa-map').displayed? }

  # test specific waits
  # worker data table
  elsif element == 'worker'
    wait.until { @driver.find_element(css: '.table.data-table').displayed? }
  end
end

def hack_Google
  # navigates to main page
  @driver.get "http://localhost:3000/"

  # logs into Google Accounts
  # inputs id and waits for password prompt
  @driver.find_element(css: '.btn-large.red').click
  waitUntil(30, 'login')
  @driver.find_element(id: 'identifierId').send_keys($login_id)
  @driver.find_element(id: 'identifierNext').click
  waitUntil(10, 'password')

  # inputs password and waits for map display
  @driver.find_element(name: 'password').send_keys($login_pass)
  @driver.find_element(id: 'passwordNext').click
  waitUntil(30, 'map')
end

def dismiss_notification
  # dismisses error messages
  if @driver.find_element(css: '.dismissButton').displayed?
    @driver.find_element(css: '.dismissButton').click
  end
end
