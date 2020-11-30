defmodule MomogogoWeb.PreferencesLive.Edit do
  use MomogogoWeb, :live_view

  alias Momogogo.Timeline

  @impl true
  def mount(_params, %{ "current_user_id" => current_user_id, "current_user_email" => current_user_email } = _session, socket) do
    preferences = Momogogo.Timeline.get_preferences_id_for_user(current_user_id)
    |> Timeline.get_preferences!()

    {
      :ok,
      socket
      |> assign(:action, :edit)
      |> assign(:preferences, preferences)
      |> assign(:changeset, Timeline.change_preferences(preferences))
    }
  end

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
         # |> push_redirect(to: socket.assigns.retdefaulturn_to)
       }

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
