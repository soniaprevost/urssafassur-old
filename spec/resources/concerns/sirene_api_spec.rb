require "rails_helper"

RSpec.describe SireneApi do
  context "generates access token" do

    it "with the correct keys" do
      VCR.use_cassette("sirene/generate_access_token_success") do
        access_token = SireneApi.generate_token(Rails.application.credentials.insee_sirene_v3[:consumer_key],
                                                Rails.application.credentials.insee_sirene_v3[:consumer_secret])
        expect(access_token).to be_present
      end
    end

    it "with no keys" do
      VCR.use_cassette("sirene/generate_access_token_failure") do
        access_token = SireneApi.generate_token("", "")
        expect(access_token).to be_nil
      end
    end
  end
end
