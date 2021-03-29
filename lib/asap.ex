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
    transaction_header =
      get_or_create(transaction, :transaction_header, %Segments.TransactionHeader{})

    information_source =
      get_or_create(transaction, :information_source, %Segments.InformationSource{})

    segments = parse_segments(transaction.segments)

    #  3 = TH + IS + TT
    transaction_trailer =
      get_or_create(transaction, :transaction_trailer, %Segments.TransactionTrailer{
        transaction_control_number: transaction_header.transaction_control_number,
        segment_count: length(segments) + 3
      })

    terminator =
      transaction_header
      |> Map.get(:segment_terminator_character, "\\")

    # this doesn't seem like the best methd
    # ([transaction_header | segments] ++ [transaction_trailer])
    ([transaction_header, information_source] ++ segments ++ [transaction_trailer])
    |> convert_segments(terminator)
  end

  def parse_segments(segments) when is_list(segments) do
    segments
    |> Enum.flat_map(&to_list/1)
  end

  def parse_segments(_), do: to_list(%{})

  defp to_list(transaction) do
    [
      get_or_create(transaction, :pharmacy_header, %Segments.PharmacyHeader{}),
      get_or_create(transaction, :patient_information, %Segments.PatientInformation{}),
      get_or_create(transaction, :dispensing_record, %Segments.DispensingRecord{}),
      get_or_create(transaction, :prescriber_information, %Segments.PrescriberInformation{}),
      get_or_create(
        transaction,
        :compound_drug_ingredient_detail,
        %Segments.CompoundDrugIngredientDetail{}
      ),
      get_or_create(
        transaction,
        :additional_information_reporting,
        %Segments.AdditionalInformationReporting{}
      ),
      get_or_create(transaction, :pharmacy_trailer, %Segments.PharmacyTrailer{})
    ]
  end

  def get_or_create(transaction, field, default) do
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
end
