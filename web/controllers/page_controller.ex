defmodule Lottery.PageController do
  use Lottery.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
