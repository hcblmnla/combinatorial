defmodule Chars do
  def is_whitespace?(code), do: code in [?\s, ?\t, ?\n, ?\r, ?\v]

  def is_letter?(code), do: code in ?a..?z or code in ?A..?Z

  def is_digit?(code), do: code in ?0..?9

  def in_string?(string) when is_bitstring(string) do
    fn code ->
      <<code>> in String.codepoints(string)
    end
  end

  def parse_integer(string) when is_bitstring(string) do
    case Integer.parse(string) do
      {integer, _} -> integer
      err -> err
    end
  end

  def parse_float(string) when is_bitstring(string) do
    case Float.parse(string) do
      {float, _} -> float
      err -> err
    end
  end
end
