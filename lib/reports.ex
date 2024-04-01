defmodule Reports do
  @moduledoc """
  Documentation for `Reports`.
  """

  @doc """
  WIP
  """
  def build(filename) do
    filename
    |> parse_file()
    |> Enum.reduce(reports_acc(), fn [id, _food_name, price], acc ->
      Map.put(acc, id, acc[id] + price)
    end)
  end

  defp parse_file(filename) do
    "reports/inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end

  defp reports_acc(), do: Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})
end
