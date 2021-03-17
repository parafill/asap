defmodule Asap.Segments.PatientInformation do
  use Asap.Base

  @moduledoc """
    Patient Information – Required

  Used to report the patient’s name and basic information as contained in the pharmacy record.
  """
  schema "PAT" do
    field(:id_quailifier_of_patient_identifier, :PAT01)
    field(:id_qualifier, :PAT02)
    field(:id, :PAT03)
    field(:id_qualifier_of_additional_patient_identifer, :PAT04)
    field(:additional_patient_id_qualifier, :PAT05)
    field(:additional_id, :PAT06)
    field(:last_name, :PAT07, required: true)
    field(:first_name, :PAT08, required: true)
    field(:middle_name, :PAT09)
    field(:name_prefix, :PAT10)
    field(:name_suffix, :PAT11)
    field(:address, :PAT12, required: true)
    field(:address_2, :PAT13)
    field(:city, :PAT14, required: true)
    field(:state, :PAT15, required: true)
    field(:zip, :PAT16, required: true)
    field(:phone, :PAT17, required: true)
    field(:date_of_birth, :PAT18, required: true)
    field(:gender, :PAT19, required: true)
    field(:species_code, :PAT20, required: true, default: "01")
    field(:patient_location_code, :PAT21)
    field(:country_of_non_us_resident, :PAT22)
    field(:name_of_animal, :PAT23)
  end
end
