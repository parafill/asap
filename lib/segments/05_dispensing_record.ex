defmodule Asap.Segments.DispensingRecord do
  use Asap.Base

  @moduledoc """
    Dispensing Record – Required

    To identify the basic components of a dispensing of a given prescription order including the date and quantity.
  """
  schema "DSP" do
    field(:reporting_status, :DSP01, required: true)
    field(:prescription_number, :DSP02, required: true)
    field(:date_written, :DSP03, required: true)
    field(:refills_authorized, :DSP04, required: true)
    field(:date_filled, :DSP05, required: true)
    field(:refill_number, :DSP06, required: true)
    field(:product_id_qualifier, :DSP07, required: true)
    field(:product_id, :DSP08, required: true)
    field(:quantity_dispensed, :DSP09, required: true)
    field(:days_supply, :DSP10, required: true)
    field(:drug_dosage_units_code, :DSP11, required: true)
    field(:transmission_of_rx_origin_code, :DSP12, required: true)
    field(:partial_fill_indicator, :DSP13, required: true)
    field(:pharmacist_npi, :DSP14)
    field(:pharmacist_state_license_number, :DSP15)
    field(:classification_code_for_payment_type, :DSP16, required: true)
    field(:date_sold, :DSP17)
    field(:rx_norm_code_qualifier, :DSP18)
    field(:rx_norm_code, :DSP19)
    field(:electronic_prescription_reference_number, :DSP20)
    field(:electronic_prescription_order_number, :DSP21)
    field(:quantity_prescribed, :DSP22)
    field(:rx_sig, :DSP23)
    field(:treatment_type, :DSP24)
    field(:diagnosis_code, :DSP25, required: true)
  end
end
