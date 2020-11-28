defmodule MomogogoWeb.PreferencesLive.Show do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:preferences, Timeline.get_preferences!(id))}
  end

  defp page_title(:show), do: "Show Preferences"
  defp page_title(:edit), do: "Edit Preferences"
end
