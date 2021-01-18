defmodule Asap.Segments.TransactionHeader do
  use Asap.Base

  @moduledoc """
  TH01
  --
  Name: Version/Release Number
  Description: Code uniquely identifying the transaction.
  Format: x.x
  Required: R

  --
  TH02
  --
  Name: Transaction Control Number
  Description: Sender assigned code uniquely identifying a transaction.
  Format:
  Required: R

  --
  TH03
  --
  Name: Transaction Type
  Description:
  Format:
  Required: R

  --
  TH04
  --
  Name: Response ID
  Description:
  Format:
  Required: N

  --
  TH05
  --
  Name: Creation Date
  Description: Date the transaction was created
  Format: CCYYMMDD
  Required: R

  --
  TH06
  --
  Name: Creation Time
  Description:
  Format: HHMMSS or HHMM
  Required: R

  --
  TH07
  --
  Name: File Type
  Description: Production (P) or Test (T)
  Format: P or T
  Required: R

  --
  TH08
  --
  Name: Routing Number
  Description: Reserved for real-time transmissions that go through a network switch to indicate, if necessary, the specific state PMP the transaction should be routed to.
  Format:
  Required: N

  --
  TH09
  --
  Name: Segment Terminator Character
  Description: Sets the actual value of the data segment terminator for the entire transaction.
  Format:
  Required: R



  example

  TH:

  TH01: 4.2A
  TH02: 123456
  TH05: 20150101
  TH06: 223000
  TH07: P
  TH09: \\

  TH*4.2A*123456*01**20150108*223000*P**\\
  """

  @send_request_transaction "01"
  @default_transaction_type @send_request_transaction

  schema "TH" do
    field(:version_number, :TH01, default: "4.2A", required: true)
    field(:transaction_control_number, :TH02, required: true)
    field(:transaction_type, :TH03, default: @default_transaction_type, required: true)
    field(:response_id, :TH04)
    field(:creation_date, :TH05, required: true)
    field(:creation_time, :TH06, required: true)
    field(:file_type, :TH07, required: true)
    field(:routing_number, :TH08)
    field(:segment_terminator_character, :TH09, default: "\\", required: true)
  end
end
