#importa classes
require_relative "routes/equipos"
require_relative "routes/sessions"
require_relative "routes/signup"
require_relative "libs/mongo"
require_relative "helpers"

require "digest/md5"
#para chave criptografada

def to_md5(pass)
  #recebe senha string normal no argumento e retorna criptografado em md5
  return Digest::MD5.hexdigest(pass)
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  #para criar a semente de massa (before global não funciona no cucumber, aqui sim)
  config.before(:suite) do
    users = [
      { name: "Roberto Silva", email: "betao@hotmail.com", password: to_md5("pwd123") },
      { name: "Tomate", email: "to@mate.com", password: to_md5("pwd123") },
      { name: "Penelope", email: "penelope@gmail.com", password: to_md5("pwd123") },
      { name: "Joe Perry", email: "joe@gmail.com", password: to_md5("pwd123") },
      { name: "Edward Cullen", email: "ed@gmail.com", password: to_md5("pwd123") },
    ]

    #mata o banco de dados
    MongoDB.new.drop_danger
    #recebe os docs da variavel users todas vez que começa o teste (sementes)
    MongoDB.new.insert_users(users)
  end
end
