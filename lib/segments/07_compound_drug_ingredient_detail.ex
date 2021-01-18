defmodule Asap.Segments.CompoundDrugIngredientDetail do
  use Asap.Base

  @moduledoc """
  Compound Drug Ingredient Detail – Situational

  To identify the individual ingredients that make up a compound.
  """

  schema "CDI" do
    field(:compound_drug_ingredient_sequence_number, :CDI01, required: true)
    field(:product_id_qualifier, :CDI02, required: true)
    field(:product_id, :CDI03, required: true)
    field(:compound_ingredient_quantity, :CDI04, required: true)
    field(:compound_drug_dosage_units_code, :CDI05, required: true)
  end
end
