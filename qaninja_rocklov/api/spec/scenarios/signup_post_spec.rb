describe "POST /signup" do
  context "novo usuario" do
    before(:all) do
      payload = { name: "Pitty", email: "pitty@bol.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])
      @result = Signup.new.create(payload)
    end

    it "valida status code" do
      # puts result.class para ver que a variável é do tipo response, temos que passar para hash
      expect(@result.code).to eql 200
    end
    it "valida id do usuário" do
      #Agora conferimos se a qtd de caracteres do id está no padrão determinado
      expect(@result.parsed_response["_id"].length).to eql 24
    end
  end

  context "usuario ja existe" do
    before(:all) do
      #dado que eu tenho um novo usuario
      payload = { name: "Joao da Silva", email: "joao@ig.com.br", password: "pwd123" }
      MongoDB.new.remove_user(payload[:email])

      #e o e-mail desse usuario já foi cadastrado no sistema
      Signup.new.create(payload)

      #quando faço uma requisição para a rota /signup
      @result = Signup.new.create(payload)
    end
    #então deve retornar
    it "deve retornar 409" do
      # puts result.class para ver que a variável é do tipo response, temos que passar para hash
      expect(@result.code).to eql 409
    end
    it "deve retornar mensagem" do
      #Agora conferimos se a qtd de caracteres do id está no padrão determinado
      expect(@result.parsed_response["error"]).to eql "Email already exists :("
    end
  end

  # Novos cenários considerando nome, email e password obrigatórios. Ver arquivo signup
  examples = Helpers::get_fixture("signup")
  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Signup.new.create (e[:payload])
      end

      it "valida status code #{e[:code]}" do
        expect(@result.code).to eql e[:code]
      end
      it "valida id do usuário" do
        expect(@result.parsed_response["error"]).to eql e[:error]
      end
    end
  end
end

#####gerando massa pra converter pra yaml
# examples = [
#   {
#     title: "senha incorreta",
#     payload: { name: "Joao da Silva", email: "joao@ig.com.br", password: "123456" },
#     code: 409,
#     error: "Email already exists :(",
#   },
#   {
#     title: "email incorreto",
#     payload: { name: "Joao da Silva", email: "joao&ig.com.br", password: "pwd123" },
#     code: 412,
#     error: "wrong email",
#   },
#   {
#     title: "nome incorreto",
#     payload: { name: "J", email: "joao@ig.com.br", password: "pwd123" },
#     code: 409,
#     error: "Email already exists :(",
#   },
#   {
#     title: "nome em branco ou sem nome",
#     payload: { name: "", email: "joao@ig.com.br", password: "pwd123" },
#     code: 412,
#     error: "required name",
#   },
#   {
#     title: "email em branco ou sem email",
#     payload: { name: "Joao da Silva", email: "", password: "pwd123" },
#     code: 412,
#     error: "required email",
#   },
#   {
#     title: "senha em branco ou sem senha",
#     payload: { name: "Joao da Silva", email: "joao@ig.com.br", password: "" },
#     code: 412,
#     error: "required password",
#   },
# ]
