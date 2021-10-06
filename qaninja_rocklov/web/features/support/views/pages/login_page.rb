class LoginPage
  include Capybara::DSL
  #a classe precisa conhecer todos os recursos do Capybara

  def open
    visit "/"
  end

  #app action (funcionalidades), o page object apenas mapeia os elementos
  def with(email, password)
    find("input[placeholder='Seu email']").set email
    find("input[type=password]").set password

    click_button "Entrar"
  end
end
