defmodule Reports do
  @moduledoc """
  Documentation for `Reports`.
  """

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pizza",
    "sushi",
    "pastel",
    "prato_feito"
  ]

  @doc """
  WIP
  """
  def build(filename) do
    filename
    |> parse_file()
    |> Enum.reduce(reports_acc(), &sum_values/2)
  end

  def most_spent_user(%{"users" => users}), do: Enum.max_by(users, fn {_k, v} -> v end)

  def best_selling_food(%{"foods" => foods}), do: Enum.max_by(foods, fn {_k, v} -> v end)

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

  defp reports_acc() do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{
      "foods" => foods,
      "users" => users
    }
  end

  defp sum_values([id, food_name, price], %{"users" => users, "foods" => foods}) do
    foods = Map.put(foods, food_name, foods[food_name] + 1)
    users = Map.put(users, id, users[id] + price)

    %{
      "foods" => foods,
      "users" => users
    }
  end
end
