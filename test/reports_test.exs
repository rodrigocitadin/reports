defmodule ReportsTest do
  use ExUnit.Case
  doctest Reports

  test "greets the world" do
    assert Reports.hello() == :world
  end
end
