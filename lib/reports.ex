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
    |> Enum.reduce(reports_acc(), &sum_values/2)
  end

  def most_spent(report), do: Enum.max_by(report, fn {_k, v} -> v end)

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

  defp sum_values([id, _food_name, price], acc), do: Map.put(acc, id, acc[id] + price)
end
