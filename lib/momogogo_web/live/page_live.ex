defmodule MomogogoWeb.PageLive do
  use MomogogoWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> push_redirect(to: MomogogoWeb.Router.Helpers.dashboard_path(socket, :index))
    }
  end

end
