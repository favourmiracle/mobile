# cucumber-appium-ruby-example



### Install appium and dependecies
T

Clone the framework


Navigate to the framework directoy

    cd cucumber-appium-ruby-example`

Install bundler and the gems the framework is dependent on

    gem install bundler
    bundle install

## Running tests

* The Appium server should be running, either from terminal or GUI.

    appium

Use Cucumber to run the tests.

    bundle exec cucumber -r features -p {CUCUMBER_PROFILE_HERE}

Cucumber profiles are listed in `cucumber.yml`.

### Android-specific features


Example:

    bundle exec cucumber -r features -p android_ci





