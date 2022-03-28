# QA automation tests of mSray using rspec and Chrome WebDriver
# moves a marker on the map

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# auth id and pass
$login_id = 'msprayapptest@gmail.com'
$login_pass = 'mSprayApp2.0'

# move offset values
$x_offset = 100
$y_offset = 100

describe "automating mSpray QA" do
  it "moves markers" do
    setup
    move_marker
    expect(@driver.find_element(css: '.fas.fa-map').displayed?)
    @driver.quit
  end
end

def move_marker
  # attempts to move a flag
  # double clicks to zoom in on map
  @driver.action.move_to(@driver.find_element(id: 'map')).double_click.double_click.perform
  waitUntil(10, 'button')

  # attempts to drag and drop a flag
  flag = @driver.find_element(css: '[role="button"]')
  @driver.action.move_to(flag).pointer_down(:left).move_by($x_offset, $y_offset).release.perform

  # clicks submit to change locations
  waitUntil(50, 'modal')
  modal = @driver.find_element(id: 'move_pin')
  # hacks clicking submit through tab and enter
  @driver.action.send_keys(modal, :tab).perform
  @driver.action.send_keys(:enter).perform
  waitUntil(30, 'map')
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
  # flags on map
  elsif element == 'button'
    wait.until { @driver.find_element(css: '[role="button"]').displayed? }
  # delete marker modal
  elsif element == 'modal'
    wait.until { @driver.find_element(id: 'move_pin').displayed? }
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
