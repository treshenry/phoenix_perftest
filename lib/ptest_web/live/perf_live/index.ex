defmodule PtestWeb.PerfLive.Index do
  use PtestWeb, :live_view

  def mount(_params, _session, socket) do
    {timer, _} = :timer.tc(fn -> shell_out() end)

    IO.puts("shell_out took #{timer} microseconds from mount")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <button phx-click="refresh">refresh</button>
    """
  end

  def handle_event("refresh", _params, socket) do
    :erlang.garbage_collect()
    {timer, _} = :timer.tc(fn -> shell_out() end)
    :erlang.garbage_collect()

    IO.puts("shell_out took #{timer} microseconds from handle_event")

    {:noreply, socket}
  end

  def shell_out() do
    System.cmd("less", ["mix.exs"])
  end
end
