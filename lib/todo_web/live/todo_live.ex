defmodule TodoWeb.TodoLive do
  use TodoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       items: [],
       activeItems: [],
       completeItems: [],
       filter: "All",
       active: false,
       light: false,
       iLeft: 0
     )}
  end

  def handle_event("mode", _params, socket) do
    if socket.assigns[:light] do
      {:noreply, assign(socket, light: false)}
    else
      {:noreply, assign(socket, light: true)}
    end
  end

  def handle_event("create_item", %{"name" => name}, socket) do
    if Enum.member?(socket.assigns[:items], name) === false do
      left = socket.assigns[:iLeft] +1
      addItem = socket.assigns[:items] ++ ["#{name}"]
      addAItem = socket.assigns[:activeItems] ++ ["#{name}"]
      {:noreply, assign(socket, items: addItem, activeItems: addAItem, iLeft: left)}
    else
      {:noreply, assign(socket, iLeft: socket.assigns[:iLeft])}
    end
  end

  def handle_event("check", %{"name" => name}, socket) do
    if Enum.member?(socket.assigns[:completeItems], name) === false do
      left = socket.assigns[:iLeft] -1
      addClearItem = socket.assigns[:completeItems] ++ ["#{name}"]
      removeActiveItem = socket.assigns[:activeItems] -- ["#{name}"]
      {:noreply, assign(socket, completeItems: addClearItem, activeItems: removeActiveItem, iLeft: left)}
    else
      left = socket.assigns[:iLeft] +1
      removeClearItem = socket.assigns[:completeItems] -- ["#{name}"]
      addActiveItem = socket.assigns[:activeItems] ++ ["#{name}"]
      {:noreply, assign(socket, completeItems: removeClearItem, activeItems: addActiveItem, iLeft: left)}
    end
  end

  def handle_event("delete_item", %{"item" => item}, socket) do
    if Enum.member?(socket.assigns[:completeItems], item) do
      removeItem = socket.assigns[:items] -- ["#{item}"]
      removeActiveItem = socket.assigns[:activeItems] -- ["#{item}"]
      removeClearItem = socket.assigns[:completeItems] -- ["#{item}"]
      {:noreply, assign(socket, items: removeItem, activeItems: removeActiveItem, completeItems: removeClearItem)}
    else
      left = length(socket.assigns[:activeItems]) - 1
      removeItem = socket.assigns[:items] -- ["#{item}"]
      removeActiveItem = socket.assigns[:activeItems] -- ["#{item}"]
      removeClearItem = socket.assigns[:completeItems] -- ["#{item}"]
      {:noreply, assign(socket, items: removeItem, activeItems: removeActiveItem, completeItems: removeClearItem, iLeft: left)}
    end
  end

  def handle_event("clear_item", _params, socket) do
    left = length(socket.assigns[:items])
    {:noreply, assign(socket, completeItems: [], activeItems: socket.assigns[:items], iLeft: left)}
  end

  def handle_event("all", _params, socket) do
    {:noreply, assign(socket, filter: "All")}
  end

  def handle_event("active", _params, socket) do
    {:noreply, assign(socket, filter: "Active")}
  end

  def handle_event("completed", _params, socket) do
    {:noreply, assign(socket, filter: "Completed")}
  end
end
