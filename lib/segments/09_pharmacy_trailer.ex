defmodule Asap.Segments.PharmacyTrailer do
  use Asap.Base

  @moduledoc """
  Pharmacy Trailer

  To identify the end of the data for a given pharmacy and to provide a count of the total number of detail segments included for the pharmacy.

  TP01
  Detail Segment Count

  """

  schema "TP" do
    field(:count, :TP01, required: true)
  end
end
