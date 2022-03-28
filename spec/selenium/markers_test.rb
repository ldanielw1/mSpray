# QA automation tests of mSray using rspec and Chrome WebDriver
# adds and deletes markers on the map

require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

# auth id and pass
$login_id = 'msprayapptest@gmail.com'
$login_pass = 'mSprayApp2.0'

def setup
  # sets up selenium webdriver test environment
  @driver = Selenium::WebDriver.for :chrome
  hack_Google
  dismiss_notification
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
  end
end

def hack_Google
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

def add_marker
  # attempts to add a malaria report flag
  # clicks on the add flag button
  @driver.find_element(css: '.fas.fa-plus').click
  @driver.find_element(css: '.btn-floating.red.toggle-add-malaria-reports').click

  # clicks on map location defined by rand offset
  map = @driver.find_element(id: 'map')
  x_offset = map.rect.x + rand(475)
  y_offset = map.rect.y + rand(629)

  #zooms in on the map
  @driver.action.move_to_location(x_offset, y_offset).double_click.perform
  @driver.action.click
end

def delete_marker
  # attempts to delete a spray data flag
  # double clicks to zoom in on map
  @driver.action.move_to(@driver.find_element(id: 'map')).double_click.double_click.perform
  waitUntil(10, 'button')

  # clicks spray data to delete it
  @driver.find_element(css: '[role="button"]').click
  @driver.action.move_to(@driver.find_element(css: '.btn.modal-trigger.delete_marker')).click
  waitUntil(10, 'password')
end

describe "automating mSpray QA" do
  it "adds markers" do
    setup
    add_marker
    expect(@driver.find_element(id: 'add_data').displayed?)
    @driver.quit
  end

  it "deletes markers" do
    setup
    delete_marker
    expect(! @driver.find_element(css: '.gm-style-iw.gm-style-iw-c').displayed?)
    @driver.quit
  end
end
