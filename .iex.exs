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


data = [th, is, pha, pat, dsp, pre, cdi, air, tp, tt]
