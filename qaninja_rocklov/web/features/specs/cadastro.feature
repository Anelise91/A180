#language: pt

Funcionalidade: Sendo um músico que possui equipamentos musicais
    Quero fazer o meu cadastro no RockLov
    Para que eu possa disponibilizá-los para locação

    @cadastro
    Cenario: Fazer cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome         | email                 | password |
            | Anelise Maia | anelisemaia@gmail.com | pwd123   |
        Então sou redirecionado para o Dashboard

    @tentativa_cadastro_
    Esquema do Cenario: Tentativa de Cadastro

        Dado que acesso a página de cadastro
        Quando submeto o seguinte formulário de cadastro:
            | nome         | email         | password      |
            | <nome_input> | <email_input> | <senha_input> |
        Então vejo a mensagem de alerta: "<mensagem_output>"

        Exemplos:
            | nome_input   | email_input           | senha_input | mensagem_output                  |
            |              | anelisemaia@gmail.com | abc123      | Oops. Informe seu nome completo! |
            | Anelise Maia |                       | pwd123      | Oops. Informe um email válido!   |
            | Anelise Maia | anelisemaia*gmail.com | pwd123      | Oops. Informe um email válido!   |
            | Anelise Maia | anelisemaia&gmail.com | pwd123      | Oops. Informe um email válido!   |
            | Anelise Maia | anelisemaia@gmail.com |             | Oops. Informe sua senha secreta! |

