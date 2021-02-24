defmodule Asap.Transaction do
  defstruct [
    :transaction_header,
    :information_source,
    :pharmacy_header,
    :patient_information,
    :dispensing_record,
    :prescriber_information,
    :compound_drug_ingredient_detail,
    :additional_information_reporting,
    :pharmacy_trailer,
    :transaction_trailer
  ]
end
