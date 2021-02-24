defmodule Asap.Segments.AdditionalInformationReporting do
  use Asap.Base

  @moduledoc """
  Additional Information Reporting - Situational

  To report other informtaion if required by the state

  """

  schema "AIR" do
    field(:state_issuing_rx_serial_number, :AIR01)
    field(:state_issued_rx_serial_number, :AIR02)
    field(:issuing_jurisdiction, :AIR03)
    field(:id_qualifier_of_person_dropping_off_or_picking_up_rx, :AIR04)
    field(:id_of_person_dropping_off_or_picking_up_rx, :AIR05)
    field(:relationshio_of_person_dropping_off_or_picking_up_rx, :AIR06)
    field(:last_name_of_person_dropping_off_or_picking_up_rx, :AIR07)
    field(:first_name_of_person_dropping_off_or_picking_up_rx, :AIR08)
    field(:last_name_or_initials_of_pharmacist, :AIR09)
    field(:first_name_of_pharmacist, :AIR10)
    field(:dropping_off_picking_up_qualifier, :AIR11)
  end
end
