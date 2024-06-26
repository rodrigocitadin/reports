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

  @spec build(String.t()) :: map()
  def build(filename) do
    filename
    |> parse_file()
    |> Enum.reduce(reports_acc(), &sum_values/2)
  end

  @spec build(list(String.t())) :: map()
  def build_many(filenames) do
    filenames
    |> Task.async_stream(&build/1)
    |> Enum.reduce(reports_acc(), fn {:ok, result}, report -> sum_reports(report, result) end)
  end

  @spec build(map()) :: {String.t(), integer()}
  def most_spent_user(%{"users" => users}), do: Enum.max_by(users, fn {_k, v} -> v end)

  @spec build(map()) :: {String.t(), integer()}
  def best_selling_food(%{"foods" => foods}), do: Enum.max_by(foods, fn {_k, v} -> v end)

  defp sum_reports(
         %{"foods" => prev_foods, "users" => prev_users},
         %{"foods" => foods, "users" => users}
       ) do
    res_foods = Map.merge(prev_foods, foods, fn _k, v1, v2 -> v1 + v2 end)
    res_users = Map.merge(prev_users, users, fn _k, v1, v2 -> v1 + v2 end)

    %{"foods" => res_foods, "users" => res_users}
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
