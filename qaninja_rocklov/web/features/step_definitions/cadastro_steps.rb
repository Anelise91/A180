Dado("que acesso a página de cadastro") do
  @signup_page.open
end

Quando("submeto o seguinte formulário de cadastro:") do |table|
  #converte pra ruby
  # log table.hashes
  #converter hash em array e first pro primeiro item já que é uma linha só
  user = table.hashes.first
  # log user

  MongoDB.new.remove_user(user[:email])
  @signup_page.create(user)
end
