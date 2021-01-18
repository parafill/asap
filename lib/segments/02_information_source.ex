defmodule Asap.Segments.InformationSource do
  use Asap.Base

  @moduledoc """
  Information Source – Required

  To convey the name and identification numbers of the entity supplying the information.
  """
  schema "IS" do
    field(:unique_information_source_id, :IS01, required: true)
    field(:information_source_entity_name, :IS02, required: true)
    field(:message, :IS03)
  end
end
