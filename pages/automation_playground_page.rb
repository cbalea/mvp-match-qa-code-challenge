module PageObjects
  class AutomationPlaygroundPage

    private def experience_input; @driver.find_element(id: "exp"); end
    private def checkbox_or_radio(value); @driver.find_element(xpath: "//input[(@type='checkbox' or @type='radio') and @value='#{value}']"); end
    private def select(value); @driver.find_element(xpath: "//select[@id='select_tool']/option[text()='#{value}']"); end
    private def output(value); @driver.find_element(xpath: "//span[contains(@class, 'text-success') and text()='#{value}']"); end

    def initialize(driver, wait)
      @driver = driver
      @wait = wait
      @driver.get('https://dineshvelhal.github.io/testautomation-playground/forms.html')
    end

    def type_and_validate_experience
      years = "15"
      experience_input.send_keys(years)
      @wait.until{ output(years).displayed? }
    end

    def select_and_validate_programming_language
      language = "PYTHON"
      checkbox_or_radio(language).click
      @wait.until{ output(language).displayed? }
    end

    def select_and_validate_automation_framework
      framework = "SELENIUM"
      checkbox_or_radio(framework).click
      @wait.until{ output(framework).displayed? }
    end

    def select_and_validate_primary_skill
      skill = "Selenium"
      select(skill).click
      @wait.until{ output(skill).displayed? }
    end
  end
end
