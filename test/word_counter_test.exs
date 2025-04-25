defmodule WordCounterTest do
  use ExUnit.Case

  setup do
    # Create temporary test files
    tmp_dir = System.tmp_dir!()

    # Simple file with basic content
    simple_path = Path.join(tmp_dir, "simple.txt")
    File.write!(simple_path, "hello world hello")

    # File with mixed case and punctuation
    complex_path = Path.join(tmp_dir, "complex.txt")
    File.write!(complex_path, "Hello, World! Hello. world? HELLO-world.")

    # File with multiple frequencies
    freq_path = Path.join(tmp_dir, "frequencies.txt")
    File.write!(freq_path, "one two two three three three")

    on_exit(fn ->
      File.rm(simple_path)
      File.rm(complex_path)
      File.rm(freq_path)
    end)

    %{
      simple_path: simple_path,
      complex_path: complex_path,
      freq_path: freq_path,
      nonexistent_path: Path.join(tmp_dir, "nonexistent.txt")
    }
  end

  test "counts words in a simple text file", %{simple_path: path} do
    result = WordCounter.count_words(path)
    assert result == [{"hello", 2}, {"world", 1}]
  end

  test "handles uppercase and punctuation", %{complex_path: path} do
    result = WordCounter.count_words(path)
    assert result == [{"hello", 3}, {"world", 2}]
  end

  test "sorts words by frequency", %{freq_path: path} do
    result = WordCounter.count_words(path)
    assert result == [{"three", 3}, {"two", 2}, {"one", 1}]
  end

  test "returns error for non-existent file", %{nonexistent_path: path} do
    result = WordCounter.count_words(path)
    assert match?({:error, _}, result)
  end

  # Run the tests when the module is executed
  def run do
    ExUnit.start(autorun: false)
    ExUnit.configure(exclude: [:skip])
    ExUnit.run()
  end
end

# Execute tests when file is run directly
if System.argv() == [] do
  WordCounterTest.run()
end
