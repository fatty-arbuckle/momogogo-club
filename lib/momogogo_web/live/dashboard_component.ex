defmodule MomogogoWeb.DashboardComponent do
  use MomogogoWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tr class="<%= if @id == @current_user_id, do: "is-selected", else: "" %>">
      <td><%= @index %></td>
      <td class="has-text-left"><%= @data.email %></td>
      <td><%= Momogogo.Helper.human_number(@data.steps) %></td>
    </tr>
    """
  end
end
