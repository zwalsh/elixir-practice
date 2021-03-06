defmodule Practice.PracticeTest do
  use ExUnit.Case
  import Practice

  test "double some numbers" do
    assert double(4) == 8
    assert double(3.5) == 7.0
    assert double(21) == 42
    assert double(0) == 0
  end

  test "factor some numbers" do
    assert factor(5) == [5]
    assert factor(8) == [2,2,2]
    assert factor(12) == [2,2,3]
    assert factor(226037113) == [3449, 65537]
    assert factor(1575) == [3,3,5,5,7]
  end

  test "evaluate some expressions" do
    assert calc("5") == {:ok, 5}
    assert calc("5 + 1") == {:ok, 6}
    assert calc("5 * 3") == {:ok, 15}
    assert calc("10 / 2") == {:ok, 5}
    assert calc("10 - 2") == {:ok, 8}
    assert calc("5 * 3 + 8") == {:ok, 23}
    assert calc("8 + 5 * 3") == {:ok, 23}
  end

  test "check some words as palindromes" do
    assert palindrome?("abba")
    assert !palindrome?("barf")
    assert !palindrome?("Abba")
    assert palindrome?("amanaplanacanalpanama")
    assert !palindrome?("A Man, a Plan, a Canal - Panama")
  end
end
