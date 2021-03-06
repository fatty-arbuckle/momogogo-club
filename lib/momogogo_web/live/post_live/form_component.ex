defmodule MomogogoWeb.PostLive.FormComponent do
  use MomogogoWeb, :live_component

  alias Momogogo.Timeline

  @impl true
  def update(%{post: post} = assigns, socket) do
    changeset = Timeline.change_post(post)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:activities, Momogogo.Activity.activities())
     |> assign(:value_label, "Minutes Spent")
   }
  end

  @impl true
  def handle_event("validate", %{"post" => post_params}, socket) do
    custom = Momogogo.Activity.custom()
    value_label = case post_params do
      %{ "activity" => ^custom } ->
        "Steps Taken"
      _ ->
        "Minutes Spent"
    end

    changeset =
      socket.assigns.post
      |> Timeline.change_post(post_params)
      |> Map.put(:action, :validate)

    {
      :noreply,
      (socket
      |> assign(:changeset, changeset)
      |> assign(:value_label, value_label))
    }
  end

  def handle_event("save", %{"post" => post_params}, socket) do
    save_post(socket, socket.assigns.action, post_params)
  end

  defp save_post(socket, :edit, post_params) do
    case Timeline.update_post(socket.assigns.post, post_params) do
      {:ok, _post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_post(socket, :new, post_params) do
    post_params = Map.put(post_params, "username", Integer.to_string(Map.get(socket.assigns, :current_user_id)))
    case Timeline.create_post(post_params) do
      {:ok, _post} ->
        {:noreply,
         socket
         |> put_flash(:info, "Post created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
