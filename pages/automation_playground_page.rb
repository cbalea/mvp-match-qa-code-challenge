require_relative 'helpers'

module PageObjects
  class AutomationPlaygroundPage

    private def experience_input; @driver.find_element(id: "exp"); end
    private def checkbox_or_radio(value); @driver.find_element(xpath: "//input[(@type='checkbox' or @type='radio') and @value='#{value}']"); end
    private def text_label(value); @driver.find_element(xpath: "//label[contains(text(), '#{value}']"); end
    private def select(value); @driver.find_element(xpath: "//select[@id='select_tool']/option[text()='#{value}']"); end
    private def multiple_select; @driver.find_element(id: "select_lang"); end
    private def textarea; @driver.find_element(xpath: "//textarea"); end
    private def input(placeholder); @driver.find_element(xpath: "//input[@placeholder='#{placeholder}']"); end
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
      @wait.until{ output(skill.downcase[0..2]).displayed? }
    end

    def select_and_validate_multiple_languages
      skill1 = "Java"
      skill2 = "Python"

      multi_selector = Selenium::WebDriver::Support::Select.new(multiple_select)
      multi_selector.select_by(:text,skill1)
      multi_selector.select_by(:text,skill2)
      @wait.until{ output(skill1.downcase + "," +skill2.downcase).displayed? }
    end

    def type_in_and_validate_textarea
      text = "Hello, my name is Joe."
      textarea.send_keys(text)
      @wait.until{ output(text).displayed? }
    end

    def mandatory_skill_input_disabled?
      text = "test"
      input("Common Sense").send_keys(text)
      return !try_action_successful?{output(text).displayed?}
    end

    def validate_speaks_german
      text_label("Speaks German?").click
      @wait.until{ output("true").displayed? }
      text_label("Speaks German?").click
      @wait.until{ output("false").displayed? }
    end
  end
end
