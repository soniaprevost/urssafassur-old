class Artisan < ApplicationRecord
  validates :secteur, presence: true
  validates :siret, length: { is: 14,
                              message: "Le champs doit comporter 14 chiffres pour un Siret" }
end
