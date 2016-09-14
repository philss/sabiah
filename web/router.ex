defmodule Sabiah.Router do
  use Sabiah.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_user_id_for_logged_user
  end

  defp put_user_id_for_logged_user(conn, _) do
    if user_id = get_session(conn, :user_id) do
      assign(conn, :user_id, user_id)
    else
      conn
    end
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
end
