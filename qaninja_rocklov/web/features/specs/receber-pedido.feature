#language: pt

Funcionalidade: Receber pedido de locação
    Sendo um anunciante que possui equipamentos cadastrados
    Desejo receber pedidos de locação
    Para que eu possa decidir se quero aprova-los ou rejeita-los

    Cenario: Receber pedido
        Dado que meu perfil de anunciante e "joao@anunciante.com" e "pwd123"
            E que eu tenho o seguinte equipamento cadastrado:
            | thumb     | trompete.jpg |
            | nome      | Trompete     |
            | categoria | Outros       |
            | preco     | 100          |
            E acesso o meu dashboard
        Quando "maria@locataria.com" e "pwd123" solicita a locacao desse equipamento
        Então devo ver seguinte mensagem:
            """
            maria@locataria.com deseja alugar o equipamento: Trompete em: DATA_ATUAL
            """
            #""" É doc_string quando o texto é maior quando argumento do step

            E devo ver os links: "ACEITAR" e "REJEITAR" no pedido