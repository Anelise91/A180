#######Massa em arquivo separado
#o método obtem a massa que está dentro da pasta fixtures
module Helpers
  def get_fixture(item)
    #Agora carrego um arquivo, leio e concateno caminho relativo do diretório de execução da API.
    #Simbolyze_names para transformar cada argumento em um símbolo, como [:payload]
    YAML.load(File.read(Dir.pwd + "/spec/fixtures/#{item}.yml"), symbolize_names: true)
  end

  def get_thumb(file_name)
    #carregamento da foto, "rb" serve pra gravar em formato binário
    return File.open(File.join(Dir.pwd, "spec/fixtures/images", file_name), "rb")
  end

  #o método get_fixture é como uma função do módulo, deve ser declarado conforme abaixo, diferente de classe:
  module_function :get_fixture
  module_function :get_thumb
end
