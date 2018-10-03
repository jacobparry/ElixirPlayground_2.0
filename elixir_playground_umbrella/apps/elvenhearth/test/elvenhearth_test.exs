defmodule ElvenhearthTest do
  use ExUnit.Case
  doctest Elvenhearth

  test "greets the world" do
    assert Elvenhearth.hello() == :world
  end
end
