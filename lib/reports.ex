defmodule Reports do
  @moduledoc """
  Documentation for `Reports`.
  """

  @doc """
  WIP
  """
  def build(filename) do
    "reports/inputs/#{filename}"
    |> File.read()
    |> handle_file()
  end

  defp handle_file({:ok, result}), do: result
  defp handle_file({:error, _reason}), do: {:error, "Error while reading the file"}
end
