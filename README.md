# Chatter
Elixir/Phoenix + React Hooks Chat app

![](https://github.com/iumehara/Chatter/workflows/API%20CI/badge.svg)
![](https://github.com/iumehara/Chatter/workflows/Web%20CI/badge.svg)



![ScreenShot](/ScreenShot.png?raw=true)

# System Dependencies
- [Erlang/Elixir](https://elixir-lang.org/install.html)
- Postgres (defaults to "postgres" user with "postgres" password)
- [Node](https://nodejs.org/)

# Tech Stack
- [Phoenix (v1.4)](https://www.phoenixframework.org/)
- [React (v16)](https://reactjs.org/)

# Getting Started
## Starting the API
```
cd api
mix deps.get
mix ecto.create
mix ecto.migrate
mix phx.server
```
API will run on `http:localhost:4000`


## Starting the Web Client
```
cd web
npm install
npm start
```
Web client will run on `http:localhost:3000`
