require "httparty"
require_relative "base_api"
#classe sessions herda as propriedades do httparty e define url padrão
#Rspec por padrão não consome api, precisa do httparty
class Signup < BaseApi
  def create(payload)

    #self.class dá acesso aos obj da própria classe
    return self.class.post(
             "/signup",
             body: payload.to_json,
             headers: {
               "Content-Type": "application/json",
             },
           )
  end
end
