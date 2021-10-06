#language: pt

Funcionalidade: Remover Anúncios
    Sendo um anunciante que possui um equipamento indesejado
    Quero poder remover esse anúncio
    Para que eu possa manter meu dashboard atualizado

    Contexto: Login
        * Login com "spider@hotmail.com" e "pwd123"
  
    Cenario: Remover um anúncio
        Dado que eu tenho um anuncio indesejado:
            | thumb     | telecaster.jpg |
            | nome      | Telecaster     |
            | categoria | Cordas         |
            | preco     | 50             |
        Quando eu solicito a exclusao desse item
            E confirmo a exclusao
        Então nao devo ver esse item no meu Dashboard

    Cenario: Desistir da Exclusão
        Dado que eu tenho um anuncio indesejado:
            | thumb     | conga.jpg |
            | nome      | Conga     |
            | categoria | Outros    |
            | preco     | 100       |
        Quando eu solicito a exclusao desse item
            Mas nao confirmo a solicitacao
        Então esse item deve permanecer no meu Dashboard