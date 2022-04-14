# log in methods for Selenium WebDriver
# sets up web testing environment

# selenium webdriver libraries
require "selenium-webdriver"
require "chromedriver-helper"

# main site
$main_url = "http://localhost:3000/"

# auth id and pass
$login_id = 'msprayapptest@gmail.com'
$login_pass = ENV["MSPRAY_AUTH_PASS"]

def set_up
  # sets up selenium webdriver test environment
  @driver = Selenium::WebDriver.for :chrome
  login_Google
  dismiss_notification
  return @driver
end

def login_Google
  # navigates to main page
  nav_tab

  # logs into Google Accounts
  # inputs id and waits for password prompt
  @driver.find_element(css: '.btn-large.red').click
  @driver.find_element(id: 'identifierId').send_keys($login_id)
  @driver.find_element(id: 'identifierNext').click
  waitUntil(10, 'password')

  # inputs password and waits for map display
  @driver.find_element(name: 'password').send_keys($login_pass)
  @driver.find_element(id: 'passwordNext').click
  waitUntil(30, 'map')
end

def nav_tab(str = '')
  # navigates to main site followed by specific directory
  urlstr = $main_url
  urlstr.concat(str)
  @driver.get urlstr
end

def dismiss_notification
  # dismisses error messages
  if @driver.find_element(css: '.dismissButton').displayed?
    @driver.find_element(css: '.dismissButton').click
  end
end

def map_view
  # for resetting map view
  nav_tab
  dismiss_notification
end

def go_tab(str)
  # attempts to navigate to the preferred tab
  tabstr = "a[href*='"
  tabstr.concat(str).concat("']")
  @driver.find_element(css: tabstr).click
  waitUntil(10, 'table')

  # returns the header element
  return @driver.find_element(css: 'h1')
end

def waitUntil(time, element)
  # waits until a predefined element displayed
  wait = Selenium::WebDriver::Wait.new(timeout: time)

  # Google login password
  if element == 'password'
    wait.until { @driver.find_element(id: 'password').displayed? }
  # mSpray map element
  elsif element == 'map'
    wait.until { @driver.find_element(css: '.fas.fa-map').displayed? }
  # flags on map
  elsif element == 'button'
    wait.until { @driver.find_element(css: '[role="button"]').displayed? }
  # delete marker modal
  elsif element == 'modal'
    wait.until { @driver.find_element(css: '.btn.modal-trigger.delete_marker').displayed? }
  # data table
  elsif (element == 'worker' or element == 'table')
    wait.until { @driver.find_element(css: '.table.data-table').displayed? }
  # data table sort up
  elsif element == 'filter_up'
    wait.until { @driver.find_element(css: '.fa.fa-angle-up').displayed? }
  # data table sort up
  elsif element == 'filter_down'
    wait.until { @driver.find_element(css: '.fa.fa-angle-down').displayed? }
  end
end
