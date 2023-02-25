require_relative 'helpers/spec_helper'
require_relative '../pages/automation_playground_page'
extend RSpec::Matchers

RSpec.describe 'Automation Playground page' do
  it 'can operate all Basic Form Controls' do
    playground_page = PageObjects::AutomationPlaygroundPage.new(@driver, @wait)
    playground_page.type_and_validate_experience
    playground_page.select_and_validate_programming_language
    playground_page.select_and_validate_automation_framework
    playground_page.select_and_validate_primary_skill
    playground_page.select_and_validate_multiple_languages
    playground_page.type_in_and_validate_textarea
    expect(playground_page.mandatory_skill_input_disabled?).to be true
    playground_page.validate_speaks_german
  end
end
