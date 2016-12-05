defmodule Lottery.Router do
  use Lottery.Web, :router

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

  scope "/", Lottery do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", Lottery do
  #   pipe_through :api
  # end

  scope "/api", Lottery do
    pipe_through :api

    post "/import/csv", ImportController, :csv

    get "/campaigns", ApiController, :campaigns
    get "/campaign/:id", ApiController, :campaign
    post "/choose/:id", ApiController, :choose
  end
end
