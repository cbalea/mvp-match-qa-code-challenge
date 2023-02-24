module PageObjects
  class AlertPage
    include RSpec::Matchers

    private def alert_button_iframe; @driver.find_element(class: "demo-frame"); end
    private def trigger_button; @driver.find_element(xpath: "//button[contains(text(),'Click the button to display an alert box:')]"); end

    def initialize(driver, wait)
      @driver = driver
      @wait = wait
      @driver.get('https://www.way2automation.com/way2auto_jquery/alert.php#load_box')
    end

    def trigger_alert
      @wait.until{alert_button_iframe}
      @driver.switch_to.frame alert_button_iframe
      trigger_button.click
    end

    def close_alert
      alert = @driver.switch_to.alert
      alert.accept
      @driver.switch_to.default_content
    end

    def assert_alert_closed
      expect { @driver.switch_to.alert }.to raise_error(Selenium::WebDriver::Error::NoSuchAlertError)
    end
  end
end
