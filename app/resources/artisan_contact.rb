class ArtisanContact

  def self.get(siret:)
    response = SireneApi.get(
      url: "https://api.insee.fr/entreprises/sirene/V3/siret/#{siret}", 
      access_token: SireneApi.generate_token(Rails.application.credentials.insee_sirene_v3[:consumer_key],
                                             Rails.application.credentials.insee_sirene_v3[:consumer_secret])
    )

    # Gestion des entreprises non diffusibles
    return "L'entreprise n'est pas diffusable" if response.body.include? "non diffusable"

    company = JSON.parse response.body

    # Gestion des indépendants
    entrepreneur_individuel = company["etablissement"]["uniteLegale"]["categorieJuridiqueUniteLegale"] == "1000"
    return "Le Siret ne correspond pas à un auto-entrepreneur" unless entrepreneur_individuel

    name = [company["etablissement"]["uniteLegale"]["sexeUniteLegale"],
            company["etablissement"]["uniteLegale"]["prenomUsuelUniteLegale"],
            company["etablissement"]["uniteLegale"]["nomUniteLegale"]].join(" ")

    ArtisanContact.new(
      name: name,
      ape: company["etablissement"]["uniteLegale"]["activitePrincipaleUniteLegale"]
    )
  end

  def initialize(name:, ape:)
    @name = name
    @ape = ape
  end

  attr_accessor :name,
                :ape
end
