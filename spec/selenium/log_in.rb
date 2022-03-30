# log in methods for Selenium WebDriver
# sets up web testing environment

require "selenium-webdriver"
require "chromedriver-helper"

# auth id and pass
$login_id = 'msprayapptest@gmail.com'
$login_pass = 'mSprayApp2.0'

def set_up
  # sets up selenium webdriver test environment
  @driver = Selenium::WebDriver.for :chrome
  login_Google
  dismiss_notification
  return @driver
end

def login_Google
  # navigates to main page
  @driver.get "http://localhost:3000/"

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

def dismiss_notification
  # dismisses error messages
  if @driver.find_element(css: '.dismissButton').displayed?
    @driver.find_element(css: '.dismissButton').click
  end
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
  end
end
