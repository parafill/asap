defmodule Asap.Segments.PrescriberInformation do
  use Asap.Base

  @moduledoc """
   Prescriber Information – Required
   To identify the prescriber of the prescription.
  """
  schema "PRE" do
    field(:npi, :PRE01, required: true)
    #  default: "1234567893")
    field(:dea, :PRE02, required: true)
    # , default: "OH1111119")
    field(:dea_number_suffix, :PRE03)
    field(:prescribing_state_license_number, :PRE04)
    field(:last_name, :PRE05, required: true)
    field(:first_name, :PRE06, required: true)
    field(:middle_name, :PRE07)
    field(:phone, :PRE08)
    field(:xdea_number, :PRE09)
  end
end
