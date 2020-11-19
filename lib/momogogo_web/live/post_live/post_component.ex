defmodule MomogogoWeb.PostLive.PostComponent do
  use MomogogoWeb, :live_component

  @impl true
  def update(%{post: post} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign(:icon, Momogogo.Activity.icon(post.activity))
   }
  end

  def render_steps(steps) when steps > 15_000, do: "fa-dizzy"
  def render_steps(steps) when steps > 10_000, do: "fa-grin-stars"
  def render_steps(steps) when steps >  6_000, do: "fa-smile"
  def render_steps(steps) when steps >  4_000, do: "fa-meh"
  def render_steps(steps) when steps >  2_000, do: "fa-frown"
  def render_steps(_steps), do: "fa-meh-rolling-eyes"

end
