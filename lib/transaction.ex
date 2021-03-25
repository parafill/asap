defmodule Asap.Transaction do
  defstruct [
    :transaction_header,
    :segments,
    :transaction_trailer
  ]
end
