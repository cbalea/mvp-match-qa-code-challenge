module PageObjects
  class RegistrationPage

    def initialize(driver, wait)
      @driver = driver
      @wait = wait
    end

    def foo; @wait.until { @driver.find_element(id: 'foo')}; end

    def load
      @driver.get('https://www.way2automation.com/way2auto_jquery/registration.php#load_box')
    end

  end
end
