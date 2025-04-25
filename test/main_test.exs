defmodule MainTest do
  use ExUnit.Case
  import ExUnit.CaptureIO

  # Test that the module has expected functions
  test "module has expected functions" do
    assert function_exported?(Main, :main, 0)
  end

  # Test the usage message when no arguments are provided
  test "main shows usage message when no arguments provided" do
    # Cria um wrapper temporário para chamar Main.main com argumentos vazios
    defmodule TestMainEmptyArgs do
      def run do
        # Substitui System.argv para retornar lista vazia
        _original_argv = :meck.new(System, [:passthrough])
        :meck.expect(System, :argv, fn -> [] end)

        try do
          Main.main()
        after
          :meck.unload(System)
        end
      end
    end

    output = capture_io(fn -> TestMainEmptyArgs.run() end)
    assert output =~ "Uso: mix run -e 'Main.main' -- caminho/para/arquivo.txt"
  end

  # Test handling of a valid file
  test "main processes valid file" do
    # Cria um wrapper temporário para chamar Main.main com argumentos e mock de retorno
    defmodule TestMainValidFile do
      def run do
        # Substitui System.argv para retornar um caminho de arquivo
        _original_argv = :meck.new(System, [:passthrough])
        :meck.expect(System, :argv, fn -> ["test_file.txt"] end)

        # Substitui WordCounter.count_words para retornar dados de teste
        _original_word_counter = :meck.new(WordCounter, [:passthrough])
        :meck.expect(WordCounter, :count_words, fn _path ->
          [{"test", 3}, {"word", 2}, {"count", 1}]
        end)

        try do
          Main.main()
        after
          :meck.unload(System)
          :meck.unload(WordCounter)
        end
      end
    end

    output = capture_io(fn -> TestMainValidFile.run() end)
    assert output =~ "test: 3"
    assert output =~ "word: 2"
    assert output =~ "count: 1"
  end

  # Test error handling
  test "main handles file reading errors" do
    # Cria um wrapper temporário para chamar Main.main com erro de arquivo
    defmodule TestMainFileError do
      def run do
        # Substitui System.argv para retornar um caminho de arquivo
        _original_argv = :meck.new(System, [:passthrough])
        :meck.expect(System, :argv, fn -> ["error_file.txt"] end)

        # Substitui WordCounter.count_words para retornar um erro
        _original_word_counter = :meck.new(WordCounter, [:passthrough])
        :meck.expect(WordCounter, :count_words, fn _path ->
          {:error, "file not found"}
        end)

        try do
          Main.main()
        after
          :meck.unload(System)
          :meck.unload(WordCounter)
        end
      end
    end

    output = capture_io(fn -> TestMainFileError.run() end)
    assert output =~ "Erro ao ler arquivo: file not found"
  end
end
