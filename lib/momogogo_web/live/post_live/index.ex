defmodule MomogogoWeb.PostLive.Index do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline
  alias Momogogo.Timeline.Post

  @impl true
  def mount(_params, %{ "current_user_id" => current_user_id, "current_user_email" => current_user_email } = session, socket) do

    if connected?(socket), do: Timeline.subscribe

    {
      :ok,
      socket
      |> assign(:posts, list_posts(Integer.to_string(current_user_id)))
      |> assign(:current_user_id, current_user_id)
      |> assign(:current_user_email, current_user_email),
      temporary_assigns: [posts: []]
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Post")
    |> assign(:post, Timeline.get_post!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Post")
    |> assign(:post, %Post{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Posts")
    |> assign(:post, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    post = Timeline.get_post!(id)
    {:ok, _} = Timeline.delete_post(post)

    {:noreply, assign(socket, :posts, list_posts("dummy"))}
  end

  @impl true
  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  @impl true
  def handle_info({:post_update, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  defp list_posts(user) do
    Timeline.list_posts(user)
  end
end
