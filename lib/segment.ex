defmodule Asap.Segment do
  defstruct [
    :information_source,
    :pharmacy_header,
    :patient_information,
    :dispensing_record,
    :prescriber_information,
    :compound_drug_ingredient_detail,
    :additional_information_reporting,
    :pharmacy_trailer
  ]
end
