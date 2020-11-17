defmodule MomogogoWeb.Pow.Routes do
  use Pow.Phoenix.Routes
  alias MomogogoWeb.Router.Helpers, as: Routes


  @impl true
  def after_sign_in_path(conn) do
    Routes.post_index_path(conn, :index)
  end

  @impl true
  def after_registration_path(conn) do
    Routes.post_index_path(conn, :index)
  end

end
