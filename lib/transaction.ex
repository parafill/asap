defmodule Asap.Transaction do
  defstruct [
    :transaction_header,
    :information_source,
    :segments,
    :transaction_trailer
  ]
end
