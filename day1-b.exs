# Advent of Code Day 1a: How many blocks away is the Easter Bunny HQ
# [Problem Description](http://adventofcode.com/2016/day/1)
# Second Solution in Elixir (script)
#
defmodule Advent do
  def walk(d, _ , {x, y}) when d == 0 do
    {x, y}
  end

  def walk(d, {offset_x, offset_y} = heading, {x,y}) when d > 0 do
    [ walk(d-1, heading, {offset_x + x, offset_y + y}) | [ {x,y} ] ]
  end

  def change_direction(turn, facing) do
    if turn == "R" do
      rem(facing+1,4) 
    else
      rem(facing-1+4,4)
    end
  end

  def head("L" <> distance, {facing, [current | _ ] = map} ) do
    {d, _} = Integer.parse(distance)

    offset = [{0,1},{1,0},{0,-1}, {-1,0}]
    new_direction = change_direction("L", facing)
    points = List.delete_at(List.flatten([walk(d, Enum.at(offset, new_direction), current)]),-1)
    { new_direction, points ++ map }
  end


  def head("R" <> distance, {facing, [current | _ ] = map} ) do
    {d, _} = Integer.parse(distance)

    offset = [{0,1},{1,0},{0,-1}, {-1,0}]
    new_direction = change_direction("R", facing)
    points = List.delete_at(List.flatten([walk(d, Enum.at(offset, new_direction), current)]),-1)

    { new_direction, points ++ map } 
  end

  def reverse({_, map}) do
    Enum.reverse(map)
  end

  def distance({x, y}) do
   abs(x) + abs(y)
  end

  def intersection(map) do
    hd( map -- Enum.uniq(map) )
  end
end

File.open!("day1-input.txt")
|> IO.read(:line)
|> String.split(", ")
|> Enum.reduce({0, [ {0,0} ]}, &Advent.head/2)
|> Advent.reverse
|> Advent.intersection
|> Advent.distance
|> IO.inspect
