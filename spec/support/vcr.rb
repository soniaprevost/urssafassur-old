require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true

  config.filter_sensitive_data('<SET-COOKIE>') do |interaction|
    interaction.response.headers['Set-Cookie']&.first
  end

  config.filter_sensitive_data('<Authorization>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end

  config.filter_sensitive_data('<Response with token>') do |interaction|
    body = interaction.response.body
    body if body.include? "access_token"
  end
end
