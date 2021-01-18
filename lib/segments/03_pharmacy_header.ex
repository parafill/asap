defmodule Asap.Segments.PharmacyHeader do
  use Asap.Base

  @moduledoc """
    Pharmacy Header – Required

  To identify the pharmacy or the dispensing prescriber. It is required that information be provided in at least one of the following fields: PHA01, PHA02, or PH03.
  """
  schema "PHA" do
    field(:npi, :PHA01, required: true)
    field(:ncpdp, :PHA02)
    field(:dea, :PHA03, required: true, default: "OH1111119")
    field(:pharmacy_name, :PHA04, required: true)
    field(:address, :PHA05, required: true)
    field(:address_2, :PHA06)
    field(:city, :PHA07, required: true)
    field(:state, :PHA08, required: true)
    field(:zip, :PHA09, required: true)
    field(:phone, :PHA10, required: true)
    field(:contact_name, :PHA11)
    field(:chain_site_id, :PHA12)
    field(:pharmacys_permit_number, :PHA13)
  end
end
