require "rails_helper"

RSpec.describe ArtisanContact do
  it "retrieve the info of an Artisan" do
    VCR.use_cassette("sirene/retrieve_artisan_contact") do
      contact = ArtisanContact.get(siret:"39860733300059")
      expect(contact.name).to eq("M BERTRAND GRONDIN")
      expect(contact.ape).to eq("47.81Z")
    end
  end
end
