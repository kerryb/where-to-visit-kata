defmodule WhereToVisit do
  @doc """
  ## Executable doctests

      iex> ts = [50, 55, 56, 57, 58]
      ...> WhereToVisit.choose_best_sum(163, 3, ts)
      163
       
      iex> xs = [50]
      ...> WhereToVisit.choose_best_sum(163, 3, xs)
      nil
       
      iex> ys = [91, 74, 73, 85, 73, 81, 87]
      ...> WhereToVisit.choose_best_sum(230, 3, ys)
      228

  """
  def choose_best_sum(max_distance, visits, distances) do
    distances
    |> comb(visits)
    |> find_longest_within_max(max_distance)
  end

  # No combinations function in stdlib, so borrowed this one from
  # https://rosettacode.org/wiki/Combinations#Elixir (swapping the argument
  # order for easier pipelining).
  defp comb(_, 0), do: [[]]
  defp comb([], _), do: []
  defp comb([h | t], m), do: for(l <- comb(t, m - 1), do: [h | l]) ++ comb(t, m)

  defp find_longest_within_max(journeys, max) do
    Enum.reduce(journeys, nil, fn journey, acc ->
      case Enum.sum(journey) do
        distance when distance > max -> acc
        distance when distance > acc or is_nil(acc) -> distance
        _ -> acc
      end
    end)
  end
end
