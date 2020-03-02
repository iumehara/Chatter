defmodule ChatterWeb.Router do
  use ChatterWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChatterWeb do
    pipe_through :api
  end
end
