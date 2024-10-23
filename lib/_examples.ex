import Combinators
import Primitives

defmodule Examples do
  def example1(input) do
    choice([
      chars("a"),
      chars("b"),
      chars("c"),
      chars("d")
    ]).(input)
  end

  def example2(input) do
    parser =
      nth(2, [
        number(),
        ws(),
        number(),
        ws(),
        number(),
        ws(),
        number()
      ])
      |> build()

    parser.(input)
  end
end
