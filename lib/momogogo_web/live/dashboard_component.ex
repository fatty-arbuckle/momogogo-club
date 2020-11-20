defmodule MomogogoWeb.DashboardComponent do
  use MomogogoWeb, :live_component

  # <!-- <tr>
  #   <th>20</th>
  #   <td><a href="https://en.wikipedia.org/wiki/Aston_Villa_F.C." title="Aston Villa F.C.">Aston Villa</a> <strong>(R)</strong>
  #   </td>
  #   <td>38</td>
  #   <td>3</td>
  #   <td>8</td>
  #   <td>27</td>
  #   <td>27</td>
  #   <td>76</td>
  #   <td>−49</td>
  #   <td>17</td>
  #   <td>Relegation to the <a href="https://en.wikipedia.org/wiki/2016%E2%80%9317_Football_League_Championship" title="2016–17 Football League Championship">Football League Championship</a></td>
  # </tr> -->

  @impl true
  def render(assigns) do
    ~L"""
    <tr class="<%= if @id == @current_user_id, do: "is-selected", else: "" %>">
      <td><%= @index %></td>
      <td class="has-text-left"><%= @data.email %></td>
      <td><%= @data.steps %></td>
    </tr>
    """
  end
end
