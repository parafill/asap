defmodule Asap do
  @moduledoc """
  Documentation for `Asap`.

  American Society for Automation in Pharmacy (ASAP) 4.2A

  This is used to comply with the PMP requirements for OARRS.

  The following elements are used

  - Segment Identifier
  - Data Delimiter (*)
  - Segment Terminator (~)

  """

  @doc """
  Convert/1

  takes a map/struct and turns it into a ASAP string
  """
  def convert(data) do
    data
    |> Enum.map(& &1.__struct__.serialize(&1))
    |> Enum.join("\n")
  end

  @doc """
  Parse/1
  takes an ASAP string and builds a map/struct
  """
  def parse(str) do
    str
  end
end
