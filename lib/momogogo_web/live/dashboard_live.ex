defmodule MomogogoWeb.DashboardLive do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline
  alias Momogogo.Timeline.Post

  @impl true
  def mount(_params, %{ "current_user_id" => current_user_id, "current_user_email" => current_user_email } = _session, socket) do

    {
      :ok,
      socket
      |> assign(:user_data, aggregate_posts())
      |> assign(:current_user_id, current_user_id)
      |> assign(:current_user_email, current_user_email),
      temporary_assigns: [posts: []]
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  defp aggregate_posts do

    stats_by_user = Timeline.list_users()
    |> Enum.reduce(%{}, fn %Momogogo.Users.User{email: email, id: id}, acc ->
      Map.put(acc, id, %{email: email, id: id, activities: 0, steps: 0})
    end)

    Timeline.list_posts(:all)
    |> Enum.reduce(stats_by_user, fn %Momogogo.Timeline.Post{username: user_id, steps: steps}, acc ->
      { id, _ } = Integer.parse(user_id)
      case Map.get(acc, id) do
        %{email: email, id: id, activities: a, steps: s} ->
          Map.put(acc, id, %{email: email, id: id, activities: a + 1, steps: s + steps})
      end
    end)
  end

end