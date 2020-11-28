defmodule MomogogoWeb.PostLive.DayComponent do
  use MomogogoWeb, :live_component

  @impl true
  def update(%{posts: posts} = assigns, socket) do
    total_steps = Enum.reduce(posts, 0, fn %{steps: steps}, acc ->
      case steps do
        nil -> acc
        _ -> acc + steps
      end
    end)
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

  def render_steps(step_scale, steps) do
    step_scale
    |> String.to_atom
    |> render_steps_icon(steps)
  end

  defp render_steps_icon(:snarky, steps) when steps > 15_000, do: "fa-dizzy"
  defp render_steps_icon(:snarky, steps) when steps > 10_000, do: "fa-grin-stars"
  defp render_steps_icon(:snarky, steps) when steps >  6_000, do: "fa-smile"
  defp render_steps_icon(:snarky, steps) when steps >  4_000, do: "fa-meh"
  defp render_steps_icon(:snarky, steps) when steps >  2_000, do: "fa-frown"
  defp render_steps_icon(:snarky, _steps), do: "fa-meh-rolling-eyes"

  defp render_steps_icon(_, steps) when steps > 12_000, do: "fa-dizzy"
  defp render_steps_icon(_, steps) when steps > 6_000, do: "fa-grin-stars"
  defp render_steps_icon(_, _steps), do: "fa-smile"

end
