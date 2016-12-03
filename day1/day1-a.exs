# Advent of Code Day 1a: How many blocks away is the Easter Bunny HQ
# [Problem Description](http://adventofcode.com/2016/day/1)
# First Solution in Elixir (script)
#
defmodule Advent do
  def walk("R" <> distance, {"N", x, y} ) do
    {d, _} = Integer.parse(distance)
    {"E", x + d, y}
  end

  def walk("R" <> distance, {"E", x, y} ) do
    {d, _} = Integer.parse(distance)
    {"S", x, y - d}
  end

  def walk("R" <> distance, {"S", x, y} ) do
    {d, _} = Integer.parse(distance)
    {"W", x - d, y}
  end

  def walk("R" <> distance, {"W", x, y} ) do
    {d, _} = Integer.parse(distance)
    {"N", x, y + d}
  end

  def walk("L" <> distance, {"N", x, y}) do
    {d, _} = Integer.parse(distance)
    {"W", x - d, y}
  end

  def walk("L" <> distance, {"W", x, y}) do
    {d, _} = Integer.parse(distance)
    {"S", x, y - d}
  end

  def walk("L" <> distance, {"S", x, y}) do
    {d, _} = Integer.parse(distance)
    {"E", x + d, y}
  end

  def walk("L" <> distance, {"E", x, y}) do
    {d, _} = Integer.parse(distance)
    {"N", x, y + d}
  end

  def distance({_, x, y}) do
   abs(x) + abs(y)
  end
end

File.open!("day1-input.txt")
|> IO.read(:line)
|> String.split(", ")
|> Enum.reduce({"N", 0, 0}, &Advent.walk/2)
|> Advent.distance
|> IO.inspect
