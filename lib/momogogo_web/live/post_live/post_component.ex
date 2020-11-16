defmodule MomogogoWeb.PostLive.PostComponent do
  use MomogogoWeb, :live_component

  def render(assigns) do

    ~L"""
    <div class="box">
      <div class="level">

        <span class=level-item"><%= @post.date %></span>
        <span class=level-item"><%= @post.activity %></span>
        <span class=level-item"><%= @post.duration %></span>
        <span class=level-item"><%= @post.steps %></span>
        <span class=level-item"></span>
        <span class=level-item"><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></span>
        <span class=level-item"><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></span>

      </div>
    </div>
    """
  end
end
