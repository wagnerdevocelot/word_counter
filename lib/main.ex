defmodule Main do
  def main do
    case System.argv() do
      [] ->
        IO.puts("Uso: mix run -e 'Main.main' -- caminho/para/arquivo.txt")

      [file_path] ->
        case WordCounter.count_words(file_path) do
          {:error, reason} ->
            IO.puts("Erro ao ler arquivo: #{reason}")

          result ->
            Enum.each(result, fn {word, count} ->
              IO.puts("#{word}: #{count}")
            end)
        end

      _ ->
        IO.puts("Uso: mix run -e 'Main.main' -- caminho/para/arquivo.txt")
    end
  end
end
