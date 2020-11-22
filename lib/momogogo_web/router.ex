defmodule MomogogoWeb.Router do
  use MomogogoWeb, :router
  use Pow.Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {MomogogoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :put_current_user
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated, error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser

    pow_routes()
  end

  scope "/", MomogogoWeb do
    pipe_through :browser

    live "/", PageLive, :index

  end

  scope "/", MomogogoWeb do
    pipe_through [:browser, :protected]
    live "/dashboard", DashboardLive, :index
    live "/posts", PostLive.Index, :index
    live "/posts/new", PostLive.Index, :new
    live "/posts/:id/edit", PostLive.Index, :edit
    live "/posts/:id", PostLive.Show, :show
    live "/posts/:id/show/edit", PostLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", MomogogoWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/internal_dashboard", metrics: MomogogoWeb.Telemetry
    end
  end

  defp put_current_user(conn, _headers) do

    case Pow.Plug.current_user(conn) do
      %{ id: id, email: email } ->
        conn
        |> put_session(:current_user_id, id)
        |> put_session(:current_user_email, email)
      _ ->
        conn
    end
  end

end
