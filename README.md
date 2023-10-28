# Teste prÃ¡tico para Desenvolvedor Ruby on Rails #

Estamos empolgados em tÃª-lo participando deste teste prÃ¡tico. Antes de mergulharmos nas questÃµes tÃ©cnicas, gostarÃ­amos de destacar que nossa equipe da CardÃ¡pio Web estÃ¡ comprometida em criar um ambiente de trabalho colaborativo, desafiador e repleto de oportunidades. Valorizamos a excelÃªncia tÃ©cnica, a inovaÃ§Ã£o e a paixÃ£o por criar soluÃ§Ãµes de alta qualidade.

Este teste prÃ¡tico Ã© mais do que uma avaliaÃ§Ã£o tÃ©cnica; Ã© uma oportunidade para vocÃª nos mostrar quem vocÃª Ã© como desenvolvedor, como pensa e como aborda os desafios. Queremos que vocÃª sinta a motivaÃ§Ã£o e o entusiasmo de se tornar parte fundamental da nossa equipe.

Agora Ã© a sua chance de mostrar seu potencial. Este teste Ã© projetado para avaliar seu conhecimento em Ruby on Rails e sua capacidade de criar soluÃ§Ãµes eficazes. Use-o como uma oportunidade para brilhar e demonstrar seu amor pela programaÃ§Ã£o.

Estamos ansiosos para ver o que vocÃª pode fazer e como vocÃª pode contribuir para a CardÃ¡pio Web. Boa sorte!

Bora codar?

O objetivo deste teste Ã© criar uma API RESTful capaz de gerenciar os proprietÃ¡rios e restaurantes de um sistema de cardÃ¡pios digitais.

## A sua API deverÃ¡ ser capaz de: ##

**ProprietÃ¡rios**

- Cadastrar novos proprietÃ¡rios.
	- Nome
	- Telefone
	- E-mail
- Listar todos os proprietÃ¡rios.
- Listar os dados de um proprietÃ¡rio.
- Alterar os dados de um proprietÃ¡rio.
- Excluir um proprietÃ¡rio.

**Restaurantes**

- Cadastrar novos restaurantes.
	- Logo do restaurante
	- Nome do restaurante
	- EndereÃ§o do restaurante
	- HorÃ¡rios de funcionamento (ex: de segunda Ã  sexta das 10h Ã s 17h e de sÃ¡bado Ã  domingo das 12h Ã s 20h)
- Listar todos os restaurantes.
- Listar os dados de um restaurante.
- Alterar os dados de um restaurante.
- Excluir um restaurante.

**Administrativo**

- Listar todos os proprietÃ¡rios juntamente com seus restaurantes.
- Endpoint para transferir um restaurante de um proprietÃ¡rio para outro.
- Endpoint para checar se um estabelecimento estÃ¡ aberto.

### ObservaÃ§Ãµes ###

- Um proprietÃ¡rio pode ter mais de um restaurante.
- Cada restaurante deve pertencer a um proprietÃ¡rio.
- Para acessar os endpoints relacionados aos restaurantes, Ã© essencial que o proprietÃ¡rio esteja autenticado por senha e autorizado a recuperar informaÃ§Ãµes exclusivamente dos restaurantes sob sua administraÃ§Ã£o. (Não ficou muito claro)
- Os endpoints dos proprietÃ¡rios e administrativos nÃ£o precisam de autenticaÃ§Ã£o.
- ApÃ³s a criaÃ§Ã£o de um estabelecimento ou apÃ³s a atualizaÃ§Ã£o do seu endereÃ§o, usar a API do Google Maps ou outra similar para obter a latitude e longitude do endereÃ§o. FaÃ§a isso em background usando o Sidekiq.
- Escreva testes para as funcionalidades que vocÃª implementou.

**Esta Ã© a estrutura base com o mÃ­nimo necessÃ¡rios, nÃ£o sintÃ¡-se limitado por ela.**

### Requisitos obrigatÃ³rios ###

- Ruby on Rails (6.0 ou superior)
- Postgres (13 ou superior)
- Docker

## InstruÃ§Ãµes ##

Para iniciar o teste, realize um fork deste repositÃ³rio e, apÃ³s a conclusÃ£o, envie-nos o link do seu repositÃ³rio. Certifique-se de criar um fork, nÃ£o um clone.

Atualize o arquivo README com instruÃ§Ãµes detalhadas sobre como executar o seu aplicativo, e inclua quaisquer comentÃ¡rios relevantes sobre o trabalho realizado.

**NÃ³s avaliaremos os seguintes aspectos da sua soluÃ§Ã£o:**

- Conhecimento de Ruby on Rails.
- Estrutura da aplicaÃ§Ã£o seguindo os requisitos mÃ­nimos.
- ImplementaÃ§Ã£o de testes.
- EstratÃ©gias de tratamento de erros.
- OrganizaÃ§Ã£o do cÃ³digo, separaÃ§Ã£o de mÃ³dulos, legibilidade e comentÃ¡rios.
- HistÃ³rico de commits.