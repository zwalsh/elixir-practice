defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> tag_tokens
    |> convert_to_postfix
    |> calc_postfix
  end

  # Tag each token as either a number or an operator
  defp tag_tokens(tokens) do
    Enum.map(tokens, fn(t) -> tag_token(t) end)
  end

  # Tag the operator as an operator
  defp tag_token(token) when token in ["+", "-", "/", "*"] do
    {:op, token}
  end

  # Parse and tag the token as a number
  defp tag_token(token) do
    {num, _} = Float.parse(token)
    {:num, num}
  end

  # Converts a tagged list of tokens to postfix notation
  def convert_to_postfix(tagged) do
    convert_to_postfix(tagged, [], [])
  end

  defp convert_to_postfix([], output, operators) do
    Enum.reverse(output) ++ operators
  end

  defp convert_to_postfix([{:num, num} | rest], output, operators) do
    convert_to_postfix(rest, [num | output], operators)
  end

  defp convert_to_postfix([{:op, op} | rest], output, []) do
    convert_to_postfix(rest, output, [op])  
  end

  defp convert_to_postfix(tagged = [{:op, op} | rest_tagged], output, ops = [top_op | rest_ops]) do
    if higher_or_equal(op, top_op) do
      convert_to_postfix(tagged, [top_op | output], rest_ops)
    else 
      convert_to_postfix(rest_tagged, output, [op | ops])
    end
  end

  defp higher_or_equal(op1, op2) when op1 in ["*", "/"] do
    op2 in ["*", "/"]
  end

  defp higher_or_equal(op1, op2) when op1 in ["-", "+"] do
    op2 in ["-", "+", "*", "/"]
  end

  # Calculates the value of a postfix expression
  def calc_postfix(expr) do
    calc_postfix(expr, [])
  end

  defp calc_postfix([], [val]) do
    {:ok, val}
  end

  defp calc_postfix([], [val | _tail]) do
    {:error, "no remaining operations, leftover token: #{val}"}
  end

  defp calc_postfix([op | tokens], [val1, val2 | vals]) when op in ["+", "-", "*", "/"] do
    calc_postfix(tokens, [execute(op, val1, val2) | vals])
  end

  defp calc_postfix([num | tail], vals) when num not in ["+", "-", "*", "/"] do
    calc_postfix(tail, [num | vals])
  end

  defp calc_postfix([op | _tokens], _vals) when op in ["+", "-", "*", "/"] do
    {:error, "got op #{op} without enough values on the stack"}
  end

  def execute("+", val1, val2) do
    val2 + val1
  end

  def execute("-", val1, val2) do
    val2 - val1
  end

  def execute("*", val1, val2) do
    val2 * val1
  end

  def execute("/", val1, val2) do
    val2 / val1
  end


  # Factor the given number into its prime factors
  def factor(x) do
    factor_from(x, 2)
  end

  # Helper that factors the number from the given starting point
  defp factor_from(x, start) do
    cond do
      start > :math.sqrt(x) -> 
        [x]
      rem(x, start) == 0 -> 
        [start] ++ factor_from(div(x, start), start)
      true -> 
        factor_from(x, start + 1)
    end
  end

end
