require 'vcr'

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.ignore_localhost = true

  config.filter_sensitive_data('<SET-COOKIE>') do |interaction|
    interaction.response.headers['Set-Cookie']&.first
  end

  config.filter_sensitive_data('<Authorization>') do |interaction|
    interaction.request.headers['Authorization']&.first
  end

  # Replace sensitive data inside hash values (ex: token)
  config.before_record do |interaction|
    if interaction.response.headers['Content-Type'] == ['application/json']
      body = interaction.response.body
      parsed_body = JSON.parse(body)
      deep_replace(parsed_body, ['access_token'])
      interaction.response.body = parsed_body.to_json
    end
  end
end


private

# Replace the values of specified keys in a Hash
# by exploring all the values of the hash recursively
# Used to filter sensitive values in cassettes
def deep_replace hash, key_names
  replace_value_by_key_name(hash, key_names)
  search_and_replace_in_sublevels(hash, key_names)
end

def replace_value_by_key_name hash, key_names
  # Is there the key we look for ?
  key_names.each do |key_name|
    if hash.key?(key_name)
      hash[key_name] = key_name
    end
  end
end

def search_and_replace_in_sublevels hash, key_names
  # We iterate on the values of the Hash
  hash.values.each do |value|
    # If the value is a Hash, we call deep_replace on it
    # to continue looking for the keys
    if value.is_a?(Hash)
      deep_replace(value, key_names)
    end
    # If the value is an Array, we check if it contains Hashes
    # and we call deep_replace on them to continue looking for the key
    if value.is_a?(Array)
      value.each do |v|
        if v.is_a?(Hash)
          deep_replace(v, key_names)
        end
      end
    end
  end
end
