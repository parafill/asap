defmodule AsapTest do
  use ExUnit.Case

  alias Asap.Transaction

  alias Asap.Segments.{
    TransactionHeader,
    InformationSource,
    PharmacyHeader,
    PatientInformation,
    DispensingRecord,
    PrescriberInformation,
    CompoundDrugIngredientDetail,
    AdditionalInformationReporting,
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

    assert TransactionHeader.serialize(th) == "TH*4.2A*123456*01**20150101*223000*P**\\\\"

    is = %InformationSource{
      unique_information_source_id: "7705555555",
      information_source_entity_name: "PHARMACY NAME",
      message: "#20150101#-#20150107#"
    }

    assert InformationSource.serialize(is) ==
             "IS*7705555555*PHARMACY NAME*#20150101#-#20150107#\\"

    pha = %PharmacyHeader{dea: "ZZ1234567"}

    assert PharmacyHeader.serialize(pha) == "PHA***ZZ1234567**********\\"

    pat = %PatientInformation{last_name: "REPORT", first_name: "ZERO"}

    assert PatientInformation.serialize(pat) == "PAT*******REPORT*ZERO************01***\\"

    dsp = %DispensingRecord{date_filled: "20150101"}

    assert DispensingRecord.serialize(dsp) == "DSP*00****20150101********************\\"

    pre = %PrescriberInformation{}

    assert PrescriberInformation.serialize(pre) == "PRE*********\\"

    cdi = %CompoundDrugIngredientDetail{}

    assert CompoundDrugIngredientDetail.serialize(cdi) == "CDI*****\\"

    air = %AdditionalInformationReporting{}

    assert AdditionalInformationReporting.serialize(air) == "AIR***********\\"

    tp = %PharmacyTrailer{count: "7"}

    assert PharmacyTrailer.serialize(tp) == "TP*7\\"

    tt = %TransactionTrailer{transaction_control_number: "123456", segment_count: "10"}

    assert TransactionTrailer.serialize(tt) == "TT*123456*10\\"

    data =
      [th, is, pha, pat, dsp, pre, cdi, air, tp, tt]
      |> Asap.convert_segments()

    assert data ==
             "TH*4.2A*123456*01**20150101*223000*P**\\\\\nIS*7705555555*PHARMACY NAME*#20150101#-#20150107#\\\nPHA***ZZ1234567**********\\\nPAT*******REPORT*ZERO************01***\\\nDSP*00****20150101********************\\\nPRE*********\\\nCDI*****\\\nAIR***********\\\nTP*7\\\nTT*123456*10\\"
  end

  test "Transaction Test" do
    th = %TransactionHeader{
      transaction_control_number: "123456",
      creation_date: "20150101",
      creation_time: "223000",
      file_type: "P"
    }

    is = %InformationSource{
      unique_information_source_id: "7705555555",
      information_source_entity_name: "PHARMACY NAME",
      message: "#20150101#-#20150107#"
    }

    pha = %PharmacyHeader{dea: "ZZ1234567"}
    pat = %PatientInformation{last_name: "REPORT", first_name: "ZERO"}
    dsp = %DispensingRecord{date_filled: "20150101"}
    pre = %PrescriberInformation{}
    cdi = %CompoundDrugIngredientDetail{}
    air = %AdditionalInformationReporting{}
    tp = %PharmacyTrailer{count: "7"}
    tt = %TransactionTrailer{transaction_control_number: "123456", segment_count: "10"}

    transaction = %Asap.Transaction{
      transaction_header: th,
      information_source: is,
      pharmacy_header: pha,
      patient_information: pat,
      dispensing_record: dsp,
      prescriber_information: pre,
      compound_drug_ingredient_detail: cdi,
      additional_information_reporting: air,
      pharmacy_trailer: tp,
      transaction_trailer: tt
    }

    result = Asap.convert(transaction)

    assert result ==
             "TH*4.2A*123456*01**20150101*223000*P**\\\\\nIS*7705555555*PHARMACY NAME*#20150101#-#20150107#\\\nPHA***ZZ1234567**********\\\nPAT*******REPORT*ZERO************01***\\\nDSP*00****20150101********************\\\nPRE*********\\\nCDI*****\\\nAIR***********\\\nTP*7\\\nTT*123456*10\\"
  end
end
