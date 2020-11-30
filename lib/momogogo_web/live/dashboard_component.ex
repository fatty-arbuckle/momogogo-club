defmodule MomogogoWeb.DashboardComponent do
  use MomogogoWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <tr class="<%= if @id == @current_user_id, do: "is-selected", else: "" %>">
      <td><%= @index %></td>
      <td class="has-text-left has-text-weight-bold"><%= @data.name %></td>
      <td class="has-test-right has-text-weight-bold"><%= Momogogo.Helper.human_number(@data.steps) %></td>
    </tr>
    """
  end
end
