defmodule MomogogoWeb.DashboardLive do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline

  @impl true
  def mount(_params, %{ "current_user_id" => current_user_id, "current_user_email" => current_user_email } = _session, socket) do
    today = Date.utc_today
    s = today
    |> Date.beginning_of_week
    |> Date.to_iso8601
    e = today
    |> Date.end_of_week
    |> Date.to_iso8601
    {
      :ok,
      socket
      |> assign(:current_user_id, current_user_id)
      |> assign(:current_user_email, current_user_email)
      |> assign_dates_and_data(s, e)
      |> clear_active
      |> assign(:limit_week_class, "is-active"),
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

  defp aggregate_posts(s, e) do
    stats_by_user = Timeline.list_users()
    |> Enum.reduce(%{}, fn %Momogogo.Users.User{email: email, id: id, name: name}, acc ->
      Map.put(acc, id, %{name: Momogogo.Helper.email_or_name(email, name), id: id, activities: 0, steps: 0})
    end)

    Timeline.list_posts(:all, s, e)
    |> Enum.reduce(stats_by_user, fn %Momogogo.Timeline.Post{username: user_id, steps: steps}, acc ->
      { id, _ } = Integer.parse(user_id)
      case Map.get(acc, id) do
        %{name: name, id: id, activities: a, steps: s} ->
          Map.put(acc, id, %{name: name, id: id, activities: a + 1, steps: s + steps})
      end
    end)
    |> Enum.sort(fn {_, x}, {_, y} ->
      x.steps > y.steps
    end)
    |> Enum.with_index
  end

  def handle_event("limit_day", _value, socket) do
    s = Date.utc_today
    |> Date.to_iso8601
    e = s
    {
      :noreply,
      socket
      |> assign_dates_and_data(s, e)
      |> clear_active
      |> assign(:limit_day_class, "is-active")
    }
  end
  def handle_event("limit_week", _value, socket) do
    today = Date.utc_today
    s = today
    |> Date.beginning_of_week
    |> Date.to_iso8601
    e = today
    |> Date.end_of_week
    |> Date.to_iso8601
    {
      :noreply,
      socket
      |> assign_dates_and_data(s, e)
      |> clear_active
      |> assign(:limit_week_class, "is-active")
    }
  end
  def handle_event("limit_month", _value, socket) do
    today = Date.utc_today
    s = today
    |> Date.beginning_of_month
    |> Date.to_iso8601
    e = today
    |> Date.end_of_month
    |> Date.to_iso8601
    {
      :noreply,
      socket
      |> assign_dates_and_data(s, e)
      |> clear_active
      |> assign(:limit_month_class, "is-active")
    }
  end
  def handle_event("limit_year", _value, socket) do
    today = Date.utc_today
    s = Date.new!(today.year, 1, 1)
    |> Date.to_iso8601
    e = Date.new!(today.year, 12, 31)
    |> Date.to_iso8601
    {
      :noreply,
      socket
      |> assign_dates_and_data(s, e)
      |> clear_active
      |> assign(:limit_year_class, "is-active")
    }
  end

  defp assign_dates_and_data(socket, s, e) do
    socket
    |> assign(:user_data, aggregate_posts(s, e))
    |> assign(:start_date, s)
    |> assign(:end_date, e)
  end

  defp clear_active(socket) do
    socket
    |> assign(:limit_day_class, "")
    |> assign(:limit_week_class, "")
    |> assign(:limit_month_class, "")
    |> assign(:limit_year_class, "")
  end

end
