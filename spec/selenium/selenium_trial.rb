require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

$login_id = 'austin.zhang@gpmail.org'
$login_pass = ''
$expected_end_Title = 'mSpray Monitor Dashboard'

def hack_Google(driver)
  driver.navigate.to "https://accounts.google.com/o/oauth2/auth/identifier?client_id=717762328687-iludtf96g1hinl76e4lc1b9a82g457nn.apps.googleusercontent.com&scope=profile%20email&redirect_uri=https%3A%2F%2Fstackauth.com%2Fauth%2Foauth2%2Fgoogle&state=%7B%22sid%22%3A1%2C%22st%22%3A%2259%3A3%3Abbc%2C16%3A7a0465bc5d6a6789%2C10%3A1648225337%2C16%3A4efa1890b19ca539%2Ca2a931d3b7c1d73d8ec82d919b8a95e49e49778f935261802cd86b3552cec39e%22%2C%22cid%22%3A%22717762328687-iludtf96g1hinl76e4lc1b9a82g457nn.apps.googleusercontent.com%22%2C%22k%22%3A%22Google%22%2C%22ses%22%3A%22a3d8d1eab0594f028b070cefd2a05c76%22%7D&response_type=code&flowName=GeneralOAuthFlow"
  fill_login(driver)
end

def press_login(driver)
  login_button = driver.find_element(css: '.btn-large.red')
  login_button.click
end

def fill_login(driver)
  driver.find_element(id: 'identifierId').send_keys($login_id)
  driver.find_element(id: 'identifierNext').click

  wait = Selenium::WebDriver::Wait.new(timeout: 10)
  wait.until { driver.find_element(id: 'password').displayed? }

  driver.find_element(name: 'password').send_keys($login_pass)
  driver.find_element(id: 'passwordNext').click
end

def get_Title(driver)
  wait = Selenium::WebDriver::Wait.new(timeout: 30)
  wait.until { driver.find_element(css: '.fas.fa-map').displayed? }
  banner = driver.title
end

describe "automating mSpray QA" do
  # it "clicks login button" do
  #   driver = Selenium::WebDriver.for :chrome
  #   driver.navigate.to "http://localhost:3000/"
  #   press_login(driver)
  #   actual_Title = driver.title
  #   expect(actual_Title).to eql('Sign in - Google Accounts')
  #   driver.quit
  # end

  it "signs in to Google" do
    driver = Selenium::WebDriver.for :chrome
    # hack_Google(driver)
    driver.navigate.to "http://localhost:3000/"
    press_login(driver)
    fill_login(driver)
    actual_Title = get_Title(driver)
    expect(actual_Title).to eql($expected_end_Title)
  end
end
