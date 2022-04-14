##
# Library file containing all helper functions related to selenium - clicking on elements, waiting for user interactions to end before taking the next action, etc.

require "selenium-webdriver"
require "chromedriver-helper"
require "rspec"

require_relative "log_in.rb"

def set_up_web_driver
  # sets up selenium webdriver test environment
  $driver = Selenium::WebDriver.for :chrome
  login_Google
  dismiss_notification
end

##
# Attempts to navigate to the preferred tab
def click_nav_tab(str)
  click("a[href*='#{str}']", "table")
end

##
# returns the header element
def page_title()
  return css('h1').text
end

##
# Gets an item by its css
def css(css, is_id=false)
  if is_id
    $driver.find_element(id: css)
  else
    $driver.find_element(css: css)
  end
end

##
# Automates the clicking of a UI element
def click(css, element_type=nil)
  css(css).click
  wait(10, element_type) if element_type != nil
end

##
# Automates the clicking of a UI element
#     NOTE: Uses the ID to designate the double-clicked object
def double_click(id, element_type=nil)
  @driver.action.move_to(css(id, true)).double_click.perform
  wait(10, element_type) if element_type != nil
end

def wait(time, element)
  # waits until a predefined element displayed
  wait = Selenium::WebDriver::Wait.new(timeout: time)

  element_classes = Hash.new
  element_classes['map'] = '.fas.fa-map'
  element_classes['button'] = '[role='button']'
  element_classes['modal'] = '.btn.modal-trigger.delete_marker'
  element_classes['worker'] = '.table.data-table'
  element_classes['table'] = '.table.data-table'
  element_classes['filter_up'] = '.fa.fa-angle-up'
  element_classes['filter_down'] = '.fa.fa-angle-down'

  if element_classes.has_key?(element)
    wait.until { $driver.find_element(css: element_classes[element]).displayed? }
  else
    wait.until { $driver.find_element(id: element).displayed? }
  end
end
