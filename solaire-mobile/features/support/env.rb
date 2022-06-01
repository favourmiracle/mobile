require 'rspec'
require 'rspec/expectations'
World(RSpec::Matchers)
require 'pry'
require 'pry-nav'
require 'json'
require 'open-uri'
require 'appium_lib'
require 'em/pure_ruby'
require 'selenium-webdriver'
require 'active_support/all'
require 'cucumber'
require 'test/unit/assertions'
require_relative '../properties/run_properties'
require_relative '../properties/environments'
include RSpec::Matchers
include Test::Unit::Assertions

desired_caps = {
  platformName: 'Android',
  deviceName: 'Android',
  platformVersion: '6.0',
  #browserName: ''
  app: 'C:\Users\sydne\Downloads\solaire-mobile\solaire-mobile\spec\driver\MySolaire_v2.0.5_apkpure.com.apk',
  #version: '4.2',
  #TODO add app activity
  package: 'com.solaireresort.mysolairemobileapp.SolaireApplication',
  appActivity: 'com.solaireresort.mysolairemobileapp.view.activity.SplashActivity',
  newCommandTimeout: 300,

  appium_lib: {
    server_url: "http://127.0.0.1/4723"
  }
}
begin
  $appium_driver = Appium::Driver.new(desired_caps, true)
  $driver = $appium_driver.start_driver
rescue Exception => e
  puts e.message
  Process.exit(0)
end



$package = '' # TODO: Put your android app package here, e.g. com.bskyb.skystore.app

# Shit hotfix for starting tests with paramaterized apk and package
$package = ENV[Environments::PACKAGE] if ENV[Environments::PACKAGE]

$id_prefix = "#{$package}:id/"

@port = ENV[Environments::PORT] || 4723

puts $package

def package
  $package
end

def props
  YAML.load_file(File.join(File.dirname(__FILE__), '/props.yml'))
end

def port
  @port
end

def simulator?
  ENV[Environments::SIMULATOR] == 'true'
end

def device?
  !simulator?
end

def iphone?
  ENV[Environments::DEVICE] == 'iphone'
end

def ipad?
  ENV[Environments::DEVICE] == 'ipad'
end

def ios?
  ipad? || iphone?
end

def external?
  ENV[Environments::APP_LOCATION] == 'external'
end

def local?
  ENV[Environments::APP_LOCATION] == 'local'
end

def app_parameter?
  ENV[Environments::IPA] || ENV[Environments::APK]
end

def android?
  ENV[Environments::DEVICE] == 'android'
end

def androidtab?
  ENV[Environments::DEVICE] == 'androidtab'
end

def should_record?
  ENV[Environments::RECORD_SCREEN] == 'true'
end

def start_appium?
  ENV[Environments::START_APPIUM] == 'true'
end

def appium_params
  ENV[Environments::APPIUM_PARAMETERS]
end

def driver
  Driver.instance.driver
end

def wait
  @wait ||= driver.manage.timeouts.implicit_wait = 90
end

def common
  @common ||= Common.new
end

def prepare_execution_device
  if device?
    RunProperties::DEVICE
  elsif simulator?
    RunProperties::SIMULATOR
  else
    fail ArgumentError, 'Please Specify a execution device'
  end
end

def prepare_location
  # if app_parameter?
  # RunProperties::APP
  #elsif external?
  #   RunProperties::EXTERNAL
  # elsif local?
    RunProperties::LOCAL
  #else
  #  fail ArgumentError, 'Application execution parameter has to be added'
  # end
end
