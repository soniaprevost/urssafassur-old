require 'rails_helper'

RSpec.describe Artisan, type: :model do
  context "Siret" do
    it "must be either 9 or 14" do
      expect { Artisan.create(siret: "123456789")}.to change { Artisan.count }.by(1)
      expect { Artisan.create(siret: "12345678901234")}.to change { Artisan.count }.by(1)
      expect { Artisan.create(siret: "123456")}.to change { Artisan.count }.by(0)
    end
  end
end
