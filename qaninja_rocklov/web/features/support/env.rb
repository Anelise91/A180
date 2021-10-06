require "allure-cucumber"
require "capybara"
require "capybara/cucumber"
require "faker"

# caminho de exec do projeto e o relativo do local .yml
#ENV é um recurso do ruby que dá acesso às variáveis de ambiente, a var CONFIG determina o ambiente que vai rodar
CONFIG = YAML.load_file(File.join(Dir.pwd, "features/support/config/#{ENV["CONFIG"]}"))

#var de amb com nome de BROWSER. A var global @driver vai recebendo os valores
case ENV["BROWSER"]
when "firefox"
  @driver = :selenium
when "chrome"
  @driver = :selenium_chrome
when "fire_headless"
  @driver = :selenium_headless
when "chrome_headless"
  Capybara.register_driver :selenium_chrome_headless do |app|
    version = Capybara::Selenium::Driver.load_selenium
    options_key = Capybara::Selenium::Driver::CAPS_VERSION.satisfied_by?(version) ? :capabilities : :options
    browser_options = ::Selenium::WebDriver::Chrome::Options.new.tap do |opts|
      opts.add_argument("--headless")
      opts.add_argument("--disable-gpu")
      opts.add_argument("--disable-site-isolation-trials")
      opts.add_argument("--no-sandbox")
      opts.add_argument("--disable-dev-shm-usage")
    end

    Capybara::Selenium::Driver.new(app, **{ :browser => :chrome, options_key => browser_options })
  end
  @driver = :selenium_chrome_headless
else
  raise "Navegador incorreto, @driver está vazio"
  #raise aborta o processo, se usar puts ele tenta rodar mesmo assim; log não funciona fora de step_definitions!!
end

Capybara.configure do |config|
  config.default_driver = @driver
  #define URL padrão
  config.app_host = CONFIG["url"]
  #pra não usar sleep, customiza tempo máx de espera dos elementos
  config.default_max_wait_time = 10
end

AllureCucumber.configure do |config|
  config.results_directory = "/logs"
  config.clean_results_directory = true
end
