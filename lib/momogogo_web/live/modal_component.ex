defmodule MomogogoWeb.ModalComponent do
  use MomogogoWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="phx-modal"
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>

      <div class="phx-modal-content">
        <%= live_patch raw("&times;"), to: @return_to, class: "phx-modal-close" %>
        <%= live_component @socket, @component, @opts %>
      </div>
    </div>
    """
  end

#   <div class="modal">
#   <div class="modal-background"></div>
#   <div class="modal-card">
#     <header class="modal-card-head">
#       <p class="modal-card-title">Modal title</p>
#       <button class="delete" aria-label="close"></button>
#     </header>
#     <section class="modal-card-body">
#       <!-- Content ... -->
#     </section>
#     <footer class="modal-card-foot">
#       <button class="button is-success">Save changes</button>
#       <button class="button">Cancel</button>
#     </footer>
#   </div>
# </div>

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
