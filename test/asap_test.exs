defmodule AsapTest do
  use ExUnit.Case

  alias Asap.Segments.{
    TransactionHeader,
    InformationSource,
    PharmacyHeader,
    PatientInformation,
    DispensingRecord,
    PrescriberInformation,
    CompoundDrugIngredientDetail,
    AdditinoalInformationReporting,
    PharmacyTrailer,
    TransactionTrailer
  }

  doctest Asap

  test "Zero Report" do
    th = %TransactionHeader{
      transaction_control_number: "123456",
      creation_date: "20150101",
      creation_time: "223000",
      file_type: "P"
    }

    assert TransactionHeader.serialize(th) == "TH*4.2A*123456*01**20150101*223000*P**\\"

    is = %InformationSource{
      unique_information_source_id: "7705555555",
      information_source_entity_name: "PHARMACY NAME",
      message: "#20150101#-#20150107#"
    }

    assert InformationSource.serialize(is) ==
             "IS*7705555555*PHARMACY NAME*#20150101#-#20150107#"

    pha = %PharmacyHeader{dea: "ZZ1234567"}

    assert PharmacyHeader.serialize(pha) == "PHA***ZZ1234567**********"

    pat = %PatientInformation{last_name: "REPORT", first_name: "ZERO"}

    assert PatientInformation.serialize(pat) == "PAT*******REPORT*ZERO***************"

    dsp = %DispensingRecord{date_filled: "20150101"}

    assert DispensingRecord.serialize(dsp) == "DSP*****20150101********************"

    pre = %PrescriberInformation{}

    assert PrescriberInformation.serialize(pre) == "PRE*********"

    cdi = %CompoundDrugIngredientDetail{}

    assert CompoundDrugIngredientDetail.serialize(cdi) == "CDI*****"

    air = %AdditinoalInformationReporting{}

    assert AdditinoalInformationReporting.serialize(air) == "AIR***********"

    tp = %PharmacyTrailer{count: "7"}

    assert PharmacyTrailer.serialize(tp) == "TP*7"

    tt = %TransactionTrailer{transaction_control_number: "123456", segment_count: "10"}

    assert TransactionTrailer.serialize(tt) == "TT*123456*10"

    data =
      [th, is, pha, pat, dsp, pre, cdi, air, tp, tt]
      |> Asap.convert()

    assert data ==
             "TH*4.2A*123456*01**20150101*223000*P**\\\nIS*7705555555*PHARMACY NAME*#20150101#-#20150107#\nPHA***ZZ1234567**********\nPAT*******REPORT*ZERO***************\nDSP*****20150101********************\nPRE*********\nCDI*****\nAIR***********\nTP*7\nTT*123456*10"
  end
end
