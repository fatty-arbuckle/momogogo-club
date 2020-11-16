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

end
