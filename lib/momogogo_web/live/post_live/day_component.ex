defmodule MomogogoWeb.PostLive.DayComponent do
  use MomogogoWeb, :live_component

  @impl true
  def update(%{posts: posts} = assigns, socket) do
    total_steps = Enum.reduce(posts, 0, fn %{steps: steps}, acc -> acc + steps end)
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:total_steps, total_steps)
     |> assign(:shade, false)
   }
  end

  @impl true
  def handle_event("toggle-shade", _value, socket) do
    {:noreply, assign(socket, :shade, !socket.assigns.shade)}
  end

  def render_steps(steps) when steps > 15_000, do: "fa-dizzy"
  def render_steps(steps) when steps > 10_000, do: "fa-grin-stars"
  def render_steps(steps) when steps >  6_000, do: "fa-smile"
  def render_steps(steps) when steps >  4_000, do: "fa-meh"
  def render_steps(steps) when steps >  2_000, do: "fa-frown"
  def render_steps(_steps), do: "fa-meh-rolling-eyes"

end
