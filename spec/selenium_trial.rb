require "selenium-webdriver"
require "rspec"
require "chromedriver-helper"

$expected_Title = 'mSpray Monitor Dashboard'

def press_login(driver)
  login_button = driver.find_element(css: '.btn-large.red')
  login_button.click


end

describe "automating mSpray QA" do
  it "clicks login button" do
    driver = Selenium::WebDriver.for :chrome
    driver.navigate.to "localhost:3000"
    press_login(driver)
    actual_Title = driver.title
    expect(actual_Title).to eql($expected_Title)
    driver.quit
  end
  # it "logs in to google" do
  #   test_login(driver)
  #   actual_Title = driver.title
  #   expect(actual_Title).to eql($expected_Title)
  # end
end
