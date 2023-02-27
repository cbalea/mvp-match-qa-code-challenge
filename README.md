## MVP Match QA Coding Challenge

### Installing the framework:
- checkout this Git repository
- install [Bundler](https://rubygems.org/gems/bundler): `gem install bundler`
- install needed project gems: `bundle install`

### Running tests locally:
- have Google Chrome installed on your machine
- navigate to the project's root folder 
- execute `bundle exec rspec specs`

### Running tests on CI:
- trigger the `Run tests` [Github Action](https://github.com/cbalea/mvp-match-qa-code-challenge/actions/workflows/run_tests.yml) 

### CI known issue:
Please note that 2 tests will fail on the remote Chrome driver which the CI uses, because of this [known issue](https://stackoverflow.com/questions/58296774/ruby-selenium-webdriver-3-142-6-unable-to-upload-file-due-to-seleniumwebdriv) with the Chromedriver and Selenium 4 when uploading files. When ran locally, those tests pass.  