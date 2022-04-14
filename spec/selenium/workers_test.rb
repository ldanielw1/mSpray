# QA automation tests of mSray using rspec and Chrome WebDriver
# tests everything related to workers - click on tab, filter, reports

# log in methods
require_relative "selenium_helper.rb"

# expected end title
$expected_title = 'Worker Data'
$expected_id = '10'
$expected_Header = 'Reports for Worker: Daniel (ID: 1)'

describe "automating mSpray QA" do
  before(:all) { setup_up_web_driver }
  before(:each) { click_nav_tab("workers/view") }
  after(:all) { $driver.close }

  it "checks workers tab" do
    expect(page_title()).to eql($expected_title)
  end

  it "attempts filter" do
    click(".filter-view-button")
    expect($driver.find_element(xpath: '//table/tbody/tr[3]/td[1]').text).to eql($expected_id)
  end

  it "checks reports" do
    download_report
    expect($driver.find_element(css: '.table.data-table').displayed?)
  end
end

def download_report
  # attempts to download a report
  # navs to report page
  $driver.find_element(css: '.btn.admin-button.blue.lighten-3').click

  #downloads a report
  $driver.find_element(css: '.btn.blue.lighten-3').click
  waitUntil(30, 'worker')
end
