defmodule Sabiah.Router do
  use Sabiah.Web, :router

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

  scope "/", Sabiah do
    pipe_through :browser # Use the default browser stack

    get "/", TimelineController, :index
    post "/follower", FollowerController, :create

    resources "/users",
              UserController,
              only: [:index, :new, :create, :show]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Sabiah do
  #   pipe_through :api
  # end
end
