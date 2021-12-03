class ArtisanInfo

  def self.get(siret:)
    response = SireneApi.get(
      url: "https://api.insee.fr/entreprises/sirene/V3/siret/#{siret}", 
      access_token: SireneApi.generate_token
    )

    company = JSON.parse response.body

    entrepreneur_individuel = company["etablissement"]["uniteLegale"]["categorieJuridiqueUniteLegale"] == "1000"
    if entrepreneur_individuel
      name = [company["etablissement"]["uniteLegale"]["sexeUniteLegale"],
              company["etablissement"]["uniteLegale"]["prenomUsuelUniteLegale"],
              company["etablissement"]["uniteLegale"]["nomUniteLegale"]].join(" ")

      ArtisanInfo.new(
        name: name,
        ape: company["etablissement"]["uniteLegale"]["activitePrincipaleUniteLegale"]
      )
    else
      return "Le Siret ne correspond pas à un auto-entrepreneur"
    end
  end

  def initialize(name:, ape:)
    @name = name
    @ape = ape
  end

  attr_accessor :name,
                :ape
end
