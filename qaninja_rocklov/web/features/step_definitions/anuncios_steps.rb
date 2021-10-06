Dado("Login com {string} e {string}") do |email, password|
  @email = email

  @login_page.open
  @login_page.with(email, password)
  #checkpoint p garantir que só sairei so step se estiver no dashboard antes de tentar obter o iod do usuario no localstorage pra remover
  expect(@dash_page.on_dash?).to be true
end

Dado("que acesso o formulário de cadastro de anúncios") do
  @dash_page.goto_equipo_form
end

Dado("que eu tenho o seguinte equipamento:") do |table|

  #método que transforma tabela chave-valor em um obj ruby
  @anuncio = table.rows_hash
  # log anuncio

  MongoDB.new.remove_equipo(@anuncio[:nome], @email)
end

Quando("submeto o cadastro desse item") do
  @equipos_page.create(@anuncio)
end

Então("devo ver esse item no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @anuncio[:nome]
  expect(@dash_page.equipo_list).to have_content "R$#{@anuncio[:preco]}/dia"
end
#have_text é se contém a frase, ignorando o ícone da msg
Então("deve conter a mensagem de alerta: {string}") do |expect_alert|
  expect(@alert.dark).to have_text expect_alert
end

### remover anuncios ####

#cadastra anuncio através da API:
Dado("que eu tenho um anuncio indesejado:") do |table|
  user_id = page.execute_script("return localStorage.getItem('user')")
  # log expect(user_id).to eql "60fb8cb86c41752cf44742d8"

  thumbnail = File.open(File.join(Dir.pwd, "features/support/fixtures/images", table.rows_hash[:thumb]), "rb")

  @equipo = {
    thumbnail: thumbnail,
    name: table.rows_hash[:nome],
    category: table.rows_hash[:categoria],
    price: table.rows_hash[:preco],
  }

  EquiposService.new.create(@equipo, user_id)
  #refresh na pag pra exibir o item cadastrado via api
  visit current_path
end

#Tudo encapsulado em page obj no dash_page
Quando("eu solicito a exclusao desse item") do
  @dash_page.request_removal(@equipo[:name])
  sleep 1 #think time
end

Quando("confirmo a exclusao") do
  @dash_page.confirm_removal
end

#desistir
Quando("nao confirmo a solicitacao") do
  @dash_page.cancel_removal
end

Então("nao devo ver esse item no meu Dashboard") do
  expect(
    @dash_page.has_no_equipo?(@equipo[:name])
  ).to be true
end

Então("esse item deve permanecer no meu Dashboard") do
  expect(@dash_page.equipo_list).to have_content @equipo[:name]
end
