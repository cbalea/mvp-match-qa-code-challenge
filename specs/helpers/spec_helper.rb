require 'rspec'
require 'selenium-webdriver'
require 'webdrivers'

RSpec.configure do |config|
  config.around(:example) do |example|
    # @driver = Selenium::WebDriver.for :chrome
    caps = Selenium::WebDriver::Remote::Capabilities.chrome("chromeOptions" => {"args" => [ "disable-infobars" ]})
    @driver = Selenium::WebDriver.for :remote, url: 'http://localhost:9515/wd/hub', desired_capabilities: caps
    @wait = Selenium::WebDriver::Wait.new(timeout: 10)
    begin
      example.run
    ensure
      @driver.quit
    end
  end
end