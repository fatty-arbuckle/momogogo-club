defmodule MomogogoWeb.PreferencesLive.FormComponent do
  use MomogogoWeb, :live_component

  alias Momogogo.Timeline

  @impl true
  def update(%{preferences: preferences} = assigns, socket) do
    changeset = Timeline.change_preferences(preferences)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"preferences" => preferences_params}, socket) do
    changeset =
      socket.assigns.preferences
      |> Timeline.change_preferences(preferences_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"preferences" => preferences_params}, socket) do
    save_preferences(socket, socket.assigns.action, preferences_params)
  end

  defp save_preferences(socket, :edit, preferences_params) do
    case Timeline.update_preferences(socket.assigns.preferences, preferences_params) do
      {:ok, _preferences} ->
        {:noreply,
         socket
         |> put_flash(:info, "Preferences updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_preferences(socket, :new, preferences_params) do
    case Timeline.create_preferences(preferences_params) do
      {:ok, _preferences} ->
        {:noreply,
         socket
         |> put_flash(:info, "Preferences created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
