describe "POST /sessions" do
  context "login com sucesso" do
    before(:all) do
      payload = { email: "betao@hotmail.com", password: "pwd123" }
      #payload com os dados do body, converter hash do ruby pra json.
      @result = Sessions.new.login(payload)
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

  #Temos um cenário dentro do contexto, quando rodar o gancho before será montado o payload
  #e faz a requisição na API guardando na var result. As validações estão independentes nos it,
  #o before é executado para cada it, então usamos o (:all) para rodar uma só vez dentro do contexto

  #Array com todos as massas de login
  # examples = [
  #   {
  #     title: "senha incorreta",
  #     payload: { email: "betao@yahoo.com", password: "123456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "usuario não existe",
  #     payload: { email: "404@yahoo.com", password: "123456" },
  #     code: 401,
  #     error: "Unauthorized",
  #   },
  #   {
  #     title: "email em branco",
  #     payload: { email: "", password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "sem o campo email",
  #     payload: { password: "123456" },
  #     code: 412,
  #     error: "required email",
  #   },
  #   {
  #     title: "senha em branco",
  #     payload: { email: "betao@yahoo.com", password: "" },
  #     code: 412,
  #     error: "required password",
  #   },
  #   {
  #     title: "sem o campo senha",
  #     payload: { email: "betao@yahoo.com" },
  #     code: 412,
  #     error: "required password",
  #   },
  # ]

  # puts examples.to_json
  #Temporário, para transformar as infos do array em json, sair do termina e colar num conversor de json para yaml online.
  #Depois insere o resultado da massa em um arq yml se quiser deixar separado no projeto
  puts examples.to_json

  #encapsulamento no módulo; caso queira criar mais massa é só invocar o módulo abaixo
  examples = Helpers::get_fixture("login")

  #argumento "e" representa um exemplo por vez
  examples.each do |e|
    context "#{e[:title]}" do
      before(:all) do
        @result = Sessions.new.login (e[:payload])
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
