defmodule PtestWeb.PerfLive.Index do
  use PtestWeb, :live_view

  def mount(_params, _session, socket) do
    {timer, _} = :timer.tc(fn -> shell_out() end)

    IO.puts("shell_out took #{timer} microseconds")

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <button phx-click="refresh">refresh</button>
    """
  end

  def handle_event("refresh", _params, socket) do
    {timer, _} = :timer.tc(fn -> shell_out() end)

    IO.puts("shell_out took #{timer} microseconds")

    {:noreply, socket}
  end

  def shell_out() do
    {output, _} = System.cmd("less", ["mix.exs"])
    output
  end
end
