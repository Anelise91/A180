class EquiposPage
  include Capybara::DSL

  def create(equipo)
    #ponto de verificação com timeout explícito se foi para o cadastro de anúncio.
    #NÃO se coloca expect em page object pra validar
    page.has_css?("#equipoForm")

    #length obtem a qtd de itens num array ou de letras em uma string.
    #No método abaixo, se não tiver nome de imagem ele faz o upload
    upload(equipo[:thumb]) if equipo[:thumb].length > 0

    find("input[placeholder$=equipamento]").set equipo[:nome]
    #caso a categoria seja vazia
    select_cat(equipo[:categoria]) if equipo[:categoria].length > 0

    find("input[placeholder^=Valor]").set equipo[:preco]

    click_button "Cadastrar"
  end

  #.set funciona pra input, não pra select
  #selecionar opção de categoria
  def select_cat(cat)
    find("#category").find("option", text: cat).select_option
  end

  def upload(file_name)
    thumb = Dir.pwd + "/features/support/fixtures/images/" + file_name
    #Recurso do Ruby que obtem o diretório de execução do projeto (c:/...)
    find("#thumbnail input[type=file]", visible: false).set thumb
  end
end
