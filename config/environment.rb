# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => 'GOOG4PI4RCOWNTIOFSJ4',
    :google_storage_secret_access_key => 'z55QnnFzJsPYWiiXrYWOsAxznLiHXxLgJjh/8+YL'
  }
  config.fog_directory = 'vitrineej'
end