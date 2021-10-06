Before do
  #monta o esquema do page object

  @login_page = LoginPage.new
  @alert = Alert.new
  @signup_page = SignupPage.new
  @dash_page = DashPage.new
  @equipos_page = EquiposPage.new

  # page.driver.browser.manage.window.maximize
  page.current_window.resize_to(1366, 768)
end

After do
  temp_shot = page.save_screenshot("logs/temp_screenshot.png")
  #add um anexo, usar 3 argumentos em símbolo
  Allure.add_attachment(
    name: "Screenshot",
    type: Allure::ContentType::PNG,
    source: File.open(temp_shot),
  )
end
