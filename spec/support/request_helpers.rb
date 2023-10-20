module Request
  module AuthHelpers
    # usado para login em controllers
    def login_as(user)
      token = JsonWebToken.encode(user_id: user.id)
      { 'Authorization' => "Bearer #{token}", 'Accept' => 'application/json' }
    end

    def response_body(symbolize_keys: false)
      json = JSON.parse(response.body)
      symbolize_keys ? json.deep_symbolize_keys : json
    end
  end
end
