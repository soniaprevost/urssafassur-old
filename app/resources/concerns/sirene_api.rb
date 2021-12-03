require 'base64'

class SireneApi
  CONSUMER_KEY = Rails.application.credentials.insee_sirene_v3[:consumer_key]
  CONSUMER_SECRET = Rails.application.credentials.insee_sirene_v3[:consumer_secret]

  def self.generate_token
    authorization_string = CONSUMER_KEY + ':' + CONSUMER_SECRET

    # Génération du jeton d'accès
    conn = Faraday.new(url: "https://api.insee.fr") do |req|
      req.headers['Authorization'] = "Basic #{Base64.strict_encode64(authorization_string)}"
      req.adapter Faraday.default_adapter
    end

    response = conn.post('/token', "grant_type=client_credentials")

    # Récupération du jeton d'accès
    data = JSON.parse response.body
    token = data["access_token"]
  end

  def self.get(url:, access_token:)
    Faraday.get(url) do |req|
      req.headers['Authorization'] = "Bearer #{access_token}"
    end
  end
end
