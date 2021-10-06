require "mongo"

Mongo::Logger.logger = Logger.new("./logs/mongo.log")

class MongoDB
  attr_accessor :client, :users, :equipos

  def initialize
    @client = Mongo::Client.new("mongodb://rocklov-db:27017/rocklov")
    @users = client[:users]
    @equipos = client[:equipos]
  end

  def drop_danger
    @client.database.drop
  end

  def insert_users(docs)
    #insere um array de documentos para cadastrar os usuarios do spec_helper
    @users.insert_many(docs)
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first
    #busca pelo e-mail e devolve pelo id do usuário
    return user[:_id]
  end

  def remove_equipo(name, user_id)
    #bson formato e mód do mongo
    obj_id = BSON::ObjectId.from_string(user_id)
    @equipos.delete_many({ name: name, user: obj_id })
  end

  #user_id nesse caso não pode ser string se no banco o tipo é diferente

  def get_mongo_id
    #cria objectid aleatorio no formato do mongo
    return BSON::ObjectId.new
  end
end
