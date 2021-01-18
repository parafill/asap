defmodule Asap.Segments.TransactionTrailer do
  use Asap.Base

  @moduledoc """
  Transaction Trailer - Required

  To identify the end of the transaction and to provide the count of the total number of segments included in the transaction.

  """

  schema "TT" do
    field(:transaction_control_number, :TT01, required: true)
    field(:segment_count, :TT02, required: true)
  end
end
