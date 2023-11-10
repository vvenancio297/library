# Ilium City Public Library


## Set up application

To run the application you must have [ruby 3.2.2](https://www.ruby-lang.org/pt/documentation/installation/) and [mysql](https://dev.mysql.com/doc/mysql-installation-excerpt/5.7/en/). After that, follow the steps below

1. Clone application using HTTPS, for example
```
$ git clone https://github.com/vvenancio297/library.git
```

2. Go to theproject directory
```
$ cd library
```

3. Install bundler, as through it we will install the dependencies defined in the Gemfile
```
$ gem install bundler -v 2.4.10
```

4. Now we just need to install the dependencies by running the command
```
$ bundle install
```

5. Finally, as a last step, we just need to define the environment variables file that must be in the file `.env`:
```
$ cp .env.sample .env
```

6. Start the server
```
$ rails server
```

Enjoy the application

## How does the app work?


### Rent process

A idéia é que os membros possa alugar os livros através deste aplicativo. Para tal, é necessário que ele efetue um cadastro (por padrão todo o usuário cadastrado será um novo membro).
Após efetuar o cadastro você será redirecionado para a listagem de livros, onde será possível efetuar a reserva através de um link. Quando a reserva for efetuada, o sistema irá gerar o número de reserva que será necessário informar ao devolver e retirar o livro

Caso você esqueça seu número de reserva, basta somente acessar a página de reservas que exibirá todas as reservas que você efetuou.

### Admin process

## Technologies

- ruby 3.2.2
- rails 7
- mysql

## Diagrams

This is the database diagram. 

![Database diagram](./docs/database_diagram.png)

## What should be better?

Thinking about more development time, I listed some topics where it would be worth making some improvements. Are they:

- add user management, making it easier to assign new admins
- add a reservation queue, so the admin must always approve reservations in an orderly manner
- use any front-end frameworks 
- implement user account recovery
- implement robust authorization 
- reservation pagination and books pagination
- add more reservation filters in the reservations page
- docker and docker-compose