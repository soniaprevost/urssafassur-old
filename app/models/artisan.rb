class Artisan < ApplicationRecord
  validates :secteur, presence: true
  validate :check_siret_length

  def check_siret_length
    unless siret.size == 9 || siret.size == 14
      errors.add(:siret, "Le champs doit comporter 9 chiffres pour un Siren ou 14 chiffres pour un Siret")
    end
  end
end
