# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

ActionMailer::Base.smtp_settings = {
  :address        => 'smtp.sendgrid.net',
  :port           => '587',
  :authentication => :plain,
  :user_name      => 'app31876307@heroku.com',
  :password       => 'swtuqhno',
  :domain         => 'heroku.com',
  :enable_starttls_auto => true
}

CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider                         => 'Google',
    :google_storage_access_key_id     => 'GOOG4PI4RCOWNTIOFSJ4',
    :google_storage_secret_access_key => 'z55QnnFzJsPYWiiXrYWOsAxznLiHXxLgJjh/8+YL'
  }
  config.fog_directory = 'vitrineej'
end