require 'base64'

class SireneApi
  CONSUMER_KEY = Rails.application.credentials.insee_sirene_v3[:consumer_key]
  CONSUMER_SECRET = Rails.application.credentials.insee_sirene_v3[:consumer_secret]

  def post(siret)
    url = "https://api.insee.fr"
    data = "grant_type=client_credentials"
    authorization_string = CONSUMER_KEY + ':' + CONSUMER_SECRET

    conn = Faraday.new(url: url) do |faraday|
      faraday.options.data = "grant_type=client_credentials"
      faraday.headers['Authorization'] = "Basic #{Base64.strict_encode64(authorization_string)}"
      faraday.adapter Faraday.default_adapter
    end

    resp = conn.get('/token') do |req|
      req.params = {"grant_type=client_credentials"}
    end

curl -k -d "grant_type=client_credentials" \
-H "Authorization: Basic oxkqmluz4jmgBtjc9PshKNw_V2oaAOZKvaUzwAOSWOaTIFe7BCW8bHoa" \
https://api.insee.fr/token


    # 1. Générer un jeton d'accès grâce à la consumer key et le secret
    # curl -k -d "grant_type=client_credentials" \
	  #   -H "Authorization: Basic Base64(key:secret)" \
    #   https://api.insee.fr/token
	  #    
    
    # 2. Récupérer le jeton d'accès et le passer dans la commande
       
    # connection = Faraday.new(url: "https://api.insee.fr/token") do |conn|
    #   conn.adapter Faraday.default_adapter # make requests with Net::HTTP
    #   conn.req.headers['Authorization'] = "Basic Base64(#{Rails.application.credentials.insee_sirene_v3[:consumerkey]}:#{Rails.application.credentials.insee_sirene_v3[:consumerkey]})"
    # end

    # response = Faraday.post("https://api.insee.fr/token") do |req|
    #   req.
    # end

    # conn = Faraday.new('https://api.insee.fr')
    # conn.basic_auth("#{Rails.application.credentials.insee_sirene_v3[:consumerkey]}","#{Rails.application.credentials.insee_sirene_v3[:consumerkey]}")
    # conn.get('/token')


    # conn = Faraday.new(
    #   url: 'https://api.insee.fr',
    #   headers: {'Authorization' => "Basic Base64(#{Rails.application.credentials.insee_sirene_v3[:consumer_key]}:#{Rails.application.credentials.insee_sirene_v3[:consumer_key]})"}
    # )

    # resp = conn.get('/token/grant_type=client_credentials')

  end


end 
