import Combinators

defmodule Primitives do
  @quotes "\""

  def chars(string), do: Chars.in_string?(string) |> char()

  def not_chars(string), do: Chars.not_in_string?(string) |> char()

  def space(), do: char(&Chars.is_whitespace?/1)

  def ws(), do: space() |> any() |> ignore()

  def digit(), do: char(&Chars.is_digit?/1)

  def digits(), do: digit() |> many()

  def number(), do: map(&Chars.parse_integer/1, digits() |> str())

  defp sign(), do: chars("+-") |> optional()

  def integer() do
    map(
      &Chars.parse_integer/1,
      sequence([
        sign(),
        digits()
      ])
      |> str()
    )
  end

  def float() do
    map(
      &Chars.parse_float/1,
      sequence(&Enum.flat_map(&1, fn p -> p end), [
        sequence([
          sign(),
          digits()
        ]),
        sequence([
          chars(".") |> optional(),
          digit() |> any()
        ])
      ])
      |> str()
    )
  end

  def string() do
    nth(1, [
      chars(@quotes),
      not_chars(@quotes) |> any() |> str(),
      chars(@quotes)
    ])
  end

  # TODO: letter, letter_or_digit, identifier, null
end
