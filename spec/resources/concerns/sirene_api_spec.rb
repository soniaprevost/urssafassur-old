require "rails_helper"

RSpec.describe SireneApi do
  context "generates access token" do
    VCR.use_cassette("sirene/generate_access_token") do
      test = SireneApi.generate_token
    end
  end
end
