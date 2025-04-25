defmodule WordCounter do
  def count_words(file_path) do
    with {:ok, content} <- File.read(file_path) do
      content
      |> String.downcase()
      # remove pontuação
      |> String.replace(~r/[^\p{L}\s]/u, "")
      |> String.split()
      |> Enum.frequencies()
      |> Enum.sort_by(&elem(&1, 1), :desc)
    else
      {:error, reason} -> {:error, reason}
    end
  end
end
