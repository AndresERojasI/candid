defmodule Candid.Router do
  use Candid.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Candid do
    pipe_through :browser # Use the default browser stack

    get "/", CandidateController, :index
    resources "/candidate/", CandidateController
    resources "/users", UserController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Candid do
  #   pipe_through :api
  # end
end
