> *Project status:* completed
> 
> *:busts_in_silhouette: Author:* Mário Augusto Carvalho Lara Leite
> 
> *:email: Email:* tkyakow@gmail.com
> 
> :date: *Year:* 2024
> 

# Case:
O usuário acessa a plataforma, realiza seu cadastro e em seguida faz seu login, caso não lembre a senha cadastrada pode recuperá-la através de seu e-mail.

Assim que estiver dentro do sistema, os dados dos contatos previamente cadastrados são exibidos na tela e então o usuário realiza o cadastro de um ou mais contatos utilizando um formulário contendo os campos necessários para o cadastro.

A plataforma possui um sistema de ajuda para o preenchimento do endereço do contato, onde o usuário pode informar alguns dados tais como, UF, cidade e um trecho do endereço e esse sistema de ajuda apresenta então as possibilidades de endereço baseado na pesquisa, dessa forma o usuário escolhe na lista qual o endereço lhe convém e tem os campos do formulário correspondente preenchidos automaticamente.

Quando o usuário quer localizar um contato na lista, ele utiliza um filtro de texto que traz apenas os contatos que contém o nome ou CPF equivalente ao termo pesquisado.

Sempre que o usuário clica no contato da lista, o mapa deve centralizar e marcar com um “pin” a coordenada geográfica obtida através do cadastro.

O usuário pode realizar a exclusão e a edição dos dados dos contatos a qualquer momento.

Se desejar, o usuário pode remover a sua própria conta, o que faz com que todos os dados cadastrados pelo mesmo sejam removidos da base de dados.

**Summary:**

Sign In, Sign up e Autenticação

Permitir que o usuário se cadastre no sistema

É permitido um usuário por e-mail cadastrado

Recuperação de senha através do e-mail

Autenticação padrão com login e senha

Assim que estiver dentro do sistema, os dados dos contatos previamente cadastrados são exibidos

Quando o usuário quer localizar um contato na lista, ele utiliza um filtro de texto

Autofill endereco - OK

O usuário pode realizar a exclusão e a edição dos dados dos contatos a qualquer momento

Se desejar, o usuário pode remover a sua própria conta, o que faz com que todos os dados cadastrados pelo mesmo sejam removidos da base de dados

Deve ser utilizado para obter a latitude e longitude do endereço do contato quando o cadastro é realizado

# Versions:
> ruby 3.3.4 (2024-07-09 revision be1089c8ec) [x86_64-linux]
> 
> Rails 7.1.4

# Tests
> Run in terminal: rspec spec

# RuboCop

![RUBOCOP!](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvMSFQaCKg10EWCRxKz6sQWiTpHbiMdqjbGA&usqp=CAU)

> Following Rubocop patterns
> 
**Thank you!**
