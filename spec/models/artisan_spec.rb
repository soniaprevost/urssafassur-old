require 'rails_helper'

RSpec.describe Artisan, type: :model do
  it { is_expected.to validate_length_of(:siret).is_equal_to(14)
                                                .with_message("Le champs doit comporter 14 chiffres pour un Siret") }
end
