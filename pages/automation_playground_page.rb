require_relative 'helpers'
include Selenium::WebDriver::Support

module PageObjects
  class AutomationPlaygroundPage

    IMAGE1_RELATIVE_PATH = 'assets/white-rectangle.png'
    IMAGE2_RELATIVE_PATH = 'assets/black-rectangle.png'
    GREEN = "rgb(63, 182, 24)"
    private def experience_input; @driver.find_element(id: "exp"); end
    private def checkbox_or_radio(value); @driver.find_element(xpath: "//input[(@type='checkbox' or @type='radio') and (@value='#{value}' or @id='#{value}')]"); end
    private def text_label(value); @driver.find_element(xpath: "//label[contains(text(), '#{value}')]"); end
    private def select(value); @driver.find_element(xpath: "//select[@id='select_tool']/option[text()='#{value}']"); end
    private def multiple_select; @driver.find_element(id: "select_lang"); end
    private def textarea; @driver.find_element(xpath: "//textarea"); end
    private def input(placeholder_or_id); @driver.find_element(xpath: "//input[@placeholder='#{placeholder_or_id}' or @id='#{placeholder_or_id}']"); end
    private def output(value); @driver.find_element(xpath: "//span[contains(@class, 'text-success') and contains(text(),'#{value}')]"); end
    private def invalid_field_error(value); @driver.find_element(xpath: "//div[@class='invalid-feedback' and contains(text(),'#{value}')]"); end
    private def validated_checkbox_message_field; @driver.find_element(xpath: "//label[@for='invalidCheck']"); end
    private def submit_button; @driver.find_element(xpath: "//button[@type='submit']"); end
    private def nonenglish_input; @driver.find_element(id: "नाव"); end
    private def nonenglish_input_label; @driver.find_element(xpath: "//label[@for='नाव']"); end

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
      return !try_action_successful?{ output(text).displayed? }
    end

    def validate_speaks_german
      text_label("Speaks German?").click
      @wait.until{ output("true").displayed? }
      text_label("Speaks German?").click
      @wait.until{ output("false").displayed? }
    end

    def validate_german_fluency_level
      input("fluency").send_keys(:left)
      @wait.until{ output("2").displayed? }
    end

    def validate_upload_cv
      filepath = absolute_filepath(IMAGE1_RELATIVE_PATH)
      if(filepath[0]==".")
        filepath = filepath[1..-1]
      end
      print "["+filepath+"]\n"
      print "filepath[0]:" + filepath[0] + "\n"
      input("upload_cv").send_keys(filepath)
      @wait.until{ output(IMAGE1_RELATIVE_PATH.split("/")[1]).displayed? }
    end

    def validate_upload_certificates
      input("upload_files").send_keys(absolute_filepath(IMAGE1_RELATIVE_PATH)+"\n"+absolute_filepath(IMAGE2_RELATIVE_PATH))
      @wait.until{ output(IMAGE1_RELATIVE_PATH.split("/")[1]+" "+IMAGE2_RELATIVE_PATH.split("/")[1]).displayed? }
    end

    def salary_field_enabled?
      input("You should not provide this").enabled?
    end

    def submit_form
      submit_button.click
    end

    def fill_form
      input("City").send_keys("Berlin")
      input("State").send_keys("Germany")
      input("Zip").send_keys("123")
      checkbox_or_radio("invalidCheck").click
    end

    def validate_error_messages_present
      @wait.until{ invalid_field_error("Please provide a valid city.").displayed? }
      @wait.until{ invalid_field_error("Please provide a valid state.").displayed? }
      @wait.until{ invalid_field_error("Please provide a valid zip.").displayed? }
      @wait.until{ invalid_field_error("You must agree before submitting.").displayed? }
    end

    def validate_form_valid
      @wait.until{ Color.from_string(input("City").css_value('border-color')).rgb == GREEN }
      @wait.until{ Color.from_string(input("State").css_value('border-color')).rgb == GREEN }
      @wait.until{ Color.from_string(input("Zip").css_value('border-color')).rgb == GREEN }
      @wait.until{ Color.from_string(validated_checkbox_message_field.css_value('color')).rgb == GREEN }
    end

    def validate_nonenglish_fields
      @wait.until{ nonenglish_input_label.displayed? }
      input("नाव").send_keys("आपले")
      @wait.until{ output("आपले").displayed? }

      checkbox_or_radio("मराठी").click
      checkbox_or_radio("ગુજરાતી").click
      checkbox_or_radio("ਪੰਜਾਬੀ").click
      @wait.until{ output("मराठी ગુજરાતી ਪੰਜਾਬੀ").displayed? }
    end

  end
end
