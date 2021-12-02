require 'base64'

class SireneApi
  CONSUMER_KEY = Rails.application.credentials.insee_sirene_v3[:consumer_key]
  CONSUMER_SECRET = Rails.application.credentials.insee_sirene_v3[:consumer_secret]

  def generate_token
    url = "https://api.insee.fr"
    authorization_string = CONSUMER_KEY + ':' + CONSUMER_SECRET

    # Génération du jeton d'accès
    conn = Faraday.new(url: url) do |req|
      req.headers['Authorization'] = "Basic #{Base64.strict_encode64(authorization_string)}"
      req.adapter Faraday.default_adapter
    end

    response = conn.post('/token', "grant_type=client_credentials")

    # Récupération du jeton d'accès
    hash = JSON.parse response.body
    token = hash["access_token"]
  end

  def retrieve_company_infos(company_number)
    return "numéro invalide" unless company_number.size == 9 || company_number.size == 14

    siret_or_siren = siret_or_siren == 9 ? "siret" : "siren"
    url = "https://api.insee.fr/entreprises/sirene/V3/#{siret_or_siren}/#{company_number}"
    access_token = self.generate_token

    response = Faraday.get(url) do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
  end
end
