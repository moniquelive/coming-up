# Coming Up...

* Ruby version
  - 3.0

* Database creation
  - `rails db:setup db:migrate`

* Database initialization
  - `rails db:migrate`

* How to run the test suite
  - `rails test`

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions
  ```shell
  ./build.sh
  ```

# Modelo

* Usuario
  - id da twitch
  - nome que veio da twitch
  - avatar que veio da twitch
  - access token
  - refresh token

* Ideia
  - Titulo
  - Corpo (markdown - https://jejacks0n.github.io/mercury/)
  * User
  * Stars
  * Comentario
  * v2: Tag

* Star
  - Usuario
  - Ideia

```text
v2: n Ideias -> n Tags
   1 Usuario -> n Ideias
   1 Usuario -> n Stars -- 1 Upvote  -> 1 Ideia
   1 Usuario -> n Comentarios
     1 Ideia -> n Comentarios
```
