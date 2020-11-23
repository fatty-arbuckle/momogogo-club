defmodule MomogogoWeb.PostLive.Index do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline
  alias Momogogo.Timeline.Post

  @impl true
  def mount(_params, %{ "current_user_id" => current_user_id, "current_user_email" => current_user_email } = _session, socket) do
    if connected?(socket), do: Timeline.subscribe
    {
      :ok,
      socket
      |> assign(:posts, list_posts(Integer.to_string(current_user_id), :fill_in_gaps))
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

    {:noreply, assign(socket, :posts, [])}
  end

  @impl true
  def handle_info({:post_created, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  @impl true
  def handle_info({:post_update, post}, socket) do
    {:noreply, update(socket, :posts, fn posts -> [post | posts] end)}
  end

  defp list_posts(user, :just_posts) do
    Timeline.list_posts(user)
    |> IO.inspect(label: "POSTS")
    |> Enum.chunk_by(fn %{date: date} -> date end)
  end

  defp list_posts(user, :fill_in_gaps) do
    posts = Timeline.list_posts(user)

    current_date = DateTime.to_date(DateTime.utc_now())
    oldest_date = case List.last(posts) do
      %{ date: date } -> Date.from_iso8601!(date)
      _ -> current_date
    end

    Enum.map(0..Date.diff(current_date, oldest_date), fn x ->
      d = to_string(Date.add(oldest_date, x))
      if Enum.find(posts, fn %{ date: date } -> date == d end) == nil do
        %Momogogo.Timeline.Post{
            activity: nil,
            date: d,
            duration: 0,
            id: nil,
            inserted_at: nil,
            steps: nil,
            updated_at: nil,
            username: nil
          }
      else
        nil
      end
    end)
    |> Enum.filter(fn x -> x != nil end)
    |> Enum.concat(posts)
    |> Enum.sort(fn x, y ->
      x.date > y.date
    end)
    |> Enum.chunk_by(fn %{date: date} -> date end)
  end



end
