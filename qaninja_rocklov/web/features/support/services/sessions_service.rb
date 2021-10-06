require_relative "base_service"

class SessionsService < BaseService
  def get_user_id(email, password)
    payload = { email: email, password: password }
    #self.class dá acesso aos obj da própria classe
    result = self.class.post(
      "/sessions",
      body: payload.to_json,
      headers: {
        "Content-Type": "application/json",
      },
    )

    return result.parsed_response["_id"]
    #devolve user_id de acordo com email e senha fazendo long API
  end
end
