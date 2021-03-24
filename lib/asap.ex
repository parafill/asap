defmodule Asap do
  alias Asap.{Transaction, Segments}

  @moduledoc """
  Documentation for `Asap`.

  American Society for Automation in Pharmacy (ASAP) 4.2A

  This is used to comply with the PMP requirements for OARRS.

  The following elements are used

  - Segment Identifier
  - Data Delimiter (*)
  - Segment Terminator (~)

  """
  @doc """
  convert
  """

  def convert(%Transaction{} = transaction) do
    terminator =
      get_or_create(transaction, :transaction_header, %Asap.Segments.TransactionHeader{})
      |> Map.get(:segment_terminator_character, "\\")

    transaction
    |> to_list()
    |> convert_segments(terminator)
  end

  defp to_list(transaction) do
    [
      get_or_create(transaction, :transaction_header, %Asap.Segments.TransactionHeader{}),
      get_or_create(transaction, :information_source, %Asap.Segments.InformationSource{}),
      get_or_create(transaction, :pharmacy_header, %Asap.Segments.PharmacyHeader{}),
      get_or_create(transaction, :patient_information, %Asap.Segments.PatientInformation{}),
      get_or_create(transaction, :dispensing_record, %Asap.Segments.DispensingRecord{}),
      get_or_create(transaction, :prescriber_information, %Asap.Segments.PrescriberInformation{}),
      get_or_create(
        transaction,
        :compound_drug_ingredient_detail,
        %Asap.Segments.CompoundDrugIngredientDetail{}
      ),
      get_or_create(
        transaction,
        :additional_information_reporting,
        %Asap.Segments.AdditionalInformationReporting{}
      ),
      get_or_create(transaction, :pharmacy_trailer, %Asap.Segments.PharmacyTrailer{}),
      get_or_create(transaction, :transaction_trailer, %Asap.Segments.TransactionTrailer{})
    ]
  end

  defp get_or_create(transaction, field, default) do
    Map.get(transaction, field)
    |> populate(default)
  end

  defp populate(val, default) when is_nil(val), do: default
  defp populate(val, _), do: val

  @doc """
  convert_segments/2

  list of segments and turns it into a ASAP string
  """
  def convert_segments(data, terminator \\ "\\") do
    data
    |> Enum.map(& &1.__struct__.serialize(&1, terminator))
    |> Enum.join("\n")
  end

  @doc """
  to_file
  """

  def to_file(content, _opts \\ []) do
    Date.utc_today()
    |> Date.to_iso8601()
    |> String.replace("-", "")
    |> add_file_suffix()
    |> File.write(content)
  end

  defp add_file_suffix(name) do
    name <> ".dat"
  end

  @doc """
  Parse/1
  takes an ASAP string and builds a map/struct
  """
  def parse(str) do
    str
  end

  defp dosage_unit_code("EA"), do: "01"
  defp dosage_unit_code(_), do: "00"
end
