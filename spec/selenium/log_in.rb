##
# Log in methods for Selenium WebDriver
# Sets up web testing environment

require "selenium-webdriver"
require "chromedriver-helper"

$main_url = "http://localhost:3000/"
$login_id = 'msprayapptest@gmail.com'
$login_pass = ENV["MSPRAY_AUTH_PASS"]

def login_Google
  # navigates to main page
  nav_tab

  # logs into Google Accounts
  # inputs id and waits for password prompt
  $driver.find_element(css: '.btn-large.red').click
  $driver.find_element(id: 'identifierId').send_keys($login_id)
  $driver.find_element(id: 'identifierNext').click
  waitUntil(10, 'password')

  # inputs password and waits for map display
  $driver.find_element(name: 'password').send_keys($login_pass)
  $driver.find_element(id: 'passwordNext').click
  waitUntil(30, 'map')
end

##
# Dismisses error messages
def dismiss_notification
  dismiss_button = $driver.find_element(css: '.dismissButton')
  dismiss_button.click if dismiss_button.displayed?
end
