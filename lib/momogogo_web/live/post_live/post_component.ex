defmodule MomogogoWeb.PostLive.PostComponent do
  use MomogogoWeb, :live_component

  def render(assigns) do
    ~L"""
    <div>
      <row id="post-<%= @post.id %>">
        <column><%= @post.username %></column>
        <column><%= @post.date %></column>
        <column><%= @post.activity %></column>
        <column><%= @post.duration %></column>
        <column><%= @post.steps %></column>
        <column><%= live_patch "Edit", to: Routes.post_index_path(@socket, :edit, @post) %></column>
        <column><%= link "Delete", to: "#", phx_click: "delete", phx_value_id: @post.id, data: [confirm: "Are you sure?"] %></column>
      </row>
    </div>
    """
  end
end
