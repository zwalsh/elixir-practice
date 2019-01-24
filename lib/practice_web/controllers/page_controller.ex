defmodule PracticeWeb.PageController do
  use PracticeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def double(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    y = Practice.double(x)
    render conn, "double.html", x: x, y: y
  end

  def calc(conn, %{"expr" => expr}) do
    {status, val} = Practice.calc(expr)
    render conn, "calc.html", expr: expr, status: status, val: val
  end

  def factor(conn, %{"x" => x}) do
    {x, _} = Integer.parse(x)
    factors = Practice.factor(x)
    render conn, "factor.html", x: x, factors: factors 
  end

  def palindrome(conn, %{"word" => word}) do
    isPalindrome = Practice.palindrome?(word)
    render conn, "palindrome.html", word: word, isPalindrome: isPalindrome
  end
end
