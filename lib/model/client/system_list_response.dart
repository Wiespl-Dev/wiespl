class SystemListResponse {
  int? status;
  int? systemCount;
  List<SystemListData>? results;

  SystemListResponse({this.status, this.systemCount, this.results});

  SystemListResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    systemCount = json['system_count'];
    if (json['results'] != null) {
      results = <SystemListData>[];
      json['results'].forEach((v) {
        results!.add(SystemListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['system_count'] = systemCount;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SystemListData {
  int? id;
  String? name;
  String? systemNumber;
  String? typeOfSystem;
  String? temperatureRangeLowLimit;
  String? temperatureRangeHighLimit;
  String? rhRangeLowLimit;
  String? rhRangeHighLimit;
  String? dpRangeLowLimit;
  String? dpRangeHighLimit;
  String? plenumSize;
  String? shrmStatus;
  String? ahuMake;
  String? designCondition;
  int? airChangesPerHour;
  String? supplyCfm;
  String? dehumidifiedCfm;
  String? bypassCfm;
  String? freshAirCfm;
  int? actualAirChanges;
  String? coolingSystem;
  String? selectedCoilAdp;
  String? coilInletTemp;
  String? coilInletRh;
  String? cwsInletTemp;
  String? cwsOutletTemp;
  String? reheat;
  int? occupancy;
  String? equipmentLoat;
  String? derationPercentage;
  String? shrm;
  String? shrmValveUsed;
  String? shrmValue;
  String? shrmReheatCapacity;
  String? shrmInitiatedDate;
  String? shrmEndDate;
  String? shrmWiesplInitiatedDate;
  String? shrmWiesplEndDate;
  String? ahu;
  String? ahuWarranty;
  String? ahuInitiatedDate;
  String? ahuEndDate;
  String? ahuWiesplInitiatedDate;
  String? ahuWiesplEndDate;
  String? blower;
  String? blowerCurve;
  String? blowerType;
  String? blowerWarranty;
  String? blowerInitiatedDate;
  String? blowerEndDate;
  String? blowerWiesplInitiatedDate;
  String? blowerWiesplEndDate;
  String? bypassMotorizedDamper;
  String? bypassMotorizedDamperOpening;
  String? coilArea;
  String? coilDepth;
  String? coilMake;
  String? coilTonnage;
  String? coilWarranty;
  String? coilInitiatedDate;
  String? coilEndDate;
  String? coilWiesplInitiatedDate;
  String? coilWiesplEndDate;
  String? damperActuator;
  String? damperWarranty;
  String? damperInitiatedDate;
  String? damperEndDate;
  String? damperWiesplInitiatedDate;
  String? damperWiesplEndDate;
  String? designVfdFrequency;
  String? freshAirDamper;
  String? freshAirDamperOpening;
  String? motorBelt;
  String? motorBeltNumber;
  String? mbInitiatedDate;
  String? mbEndDate;
  String? mbWiesplInitiatedDate;
  String? mbWiesplEndDate;
  String? motorKw;
  String? motorMake;
  String? motorStatic;
  String? motor;
  String? motorType;
  String? motorInitiatedDate;
  String? motorEndDate;
  String? motorWiesplInitiatedDate;
  String? motorWiesplEndDate;
  String? motorPully;
  String? mpInitiatedDate;
  String? mpEndDate;
  String? mpWiesplInitiatedDate;
  String? mpWiesplEndDate;
  String? returnAirDamper;
  String? returnAirDamperOpening;
  String? vfdKw;
  String? vfdMake;
  String? adInitiatedDate;
  String? adEndDate;
  String? adWiesplInitiatedDate;
  String? adWiesplEndDate;
  String? exhaustFanCfm;
  int? noOfHeater1Banks;
  String? heater1Kw;
  String? heater1Type;
  String? heater1Warranty;
  String? heater1InitiatedDate;
  String? heater1EndDate;
  String? heater1WiesplInitiatedDate;
  String? heater1WiesplEndDate;
  int? noOfHeater2Banks;
  String? heater2Kw;
  String? heater2Type;
  String? heater2Warranty;
  String? heater2InitiatedDate;
  String? heater2EndDate;
  String? heater2WiesplInitiatedDate;
  String? heater2WiesplEndDate;
  int? noOfHeater3Banks;
  String? heater3Kw;
  String? heater3Type;
  String? heater3Warranty;
  String? heater3InitiatedDate;
  String? heater3EndDate;
  String? heater3WiesplInitiatedDate;
  String? heater3WiesplEndDate;
  int? noOfHeater4Banks;
  String? heater4Kw;
  String? heater4Type;
  String? heater4Warranty;
  String? heater4InitiatedDate;
  String? heater4EndDate;
  String? heater4WiesplInitiatedDate;
  String? heater4WiesplEndDate;
  String? acdPipeLength;
  String? acdOduTonnage;
  String? acdOduTonnageMake;
  String? acdOdutInitiatedDate;
  String? acdOdutEndDate;
  String? acdOdutWiesplInitiatedDate;
  String? acdOdutWiesplEndDate;
  String? acdOduCompressor;
  String? acdOduCompressorType;
  String? acdOduCompressorMake;
  String? acdOducInitiatedDate;
  String? acdOducEndDate;
  String? acdOducWiesplInitiatedDate;
  String? acdOducWiesplEndDate;
  String? acdOduCondenserFanMotor;
  String? acdOducfmInitiatedDate;
  String? acdOducfmEndDate;
  String? acdOducfmWiesplInitiatedDate;
  String? acdOducfmWiesplEndDate;
  String? acdOduCondenserFanBlade;
  String? acdOduCondenserFanBladeWarranty;
  String? acdOducfbInitiatedDate;
  String? acdOducfbEndDate;
  String? acdOducfbWiesplInitiatedDate;
  String? acdOducfbWiesplEndDate;
  String? acdExpensionDevice;
  String? acdEdInitiatedDate;
  String? acdEdEndDate;
  String? acdEdWiesplInitiatedDate;
  String? acdEdWiesplEndDate;
  String? acdDryerFilter;
  String? acdDfInitiatedDate;
  String? acdDfEndDate;
  String? acdDfWiesplInitiatedDate;
  String? acdDfWiesplEndDate;
  String? acdLpSwitch;
  String? acdLpsInitiatedDate;
  String? acdLpsEndDate;
  String? acdLpsWiesplInitiatedDate;
  String? acdLpsWiesplEndDate;
  String? acdHpSwitch;
  String? acdHpsInitiatedDate;
  String? acdHpsEndDate;
  String? acdHpsWiesplInitiatedDate;
  String? acdHpsWiesplEndDate;
  String? acdOduGas;
  String? acdOduGasQuantity;
  String? oduTonnage;
  String? oduTonnageMake;
  String? odutInitiatedDate;
  String? odutEndDate;
  String? odutWiesplInitiatedDate;
  String? odutWiesplEndDate;
  String? oduCompressor;
  String? oduCompressorType;
  String? oduCompressorMake;
  String? oducInitiatedDate;
  String? oducEndDate;
  String? oducWiesplInitiatedDate;
  String? oducWiesplEndDate;
  String? oduCondenserFanMotor;
  String? oducfmInitiatedDate;
  String? oducfmEndDate;
  String? oducfmWiesplInitiatedDate;
  String? oducfmWiesplEndDate;
  String? oduCondenserFanBlade;
  String? oducfbInitiatedDate;
  String? oducfbEndDate;
  String? oducfbWiesplInitiatedDate;
  String? oducfbWiesplEndDate;
  String? expensionDevice;
  String? edInitiatedDate;
  String? edEndDate;
  String? edWiesplInitiatedDate;
  String? edWiesplEndDate;
  String? dryerFilter;
  String? dfInitiatedDate;
  String? dfEndDate;
  String? dfWiesplInitiatedDate;
  String? dfWiesplEndDate;
  String? lpSwitch;
  String? lpsInitiatedDate;
  String? lpsEndDate;
  String? lpsWiesplInitiatedDate;
  String? lpsWiesplEndDate;
  String? hpSwitch;
  String? hpsInitiatedDate;
  String? hpsEndDate;
  String? hpsWiesplInitiatedDate;
  String? hpsWiesplEndDate;
  String? oduGas;
  String? oduGasQuantity;
  String? fireDamper;
  String? fireDamperAccuator;
  String? thermalExpansionDevice;
  int? expansionValveOrifice;
  String? thyristor;
  String? thyristorInitiatedDate;
  String? thyristorEndDate;
  String? thyristorWiesplInitiatedDate;
  String? thyristorWiesplEndDate;
  String? plc;
  String? plcInitiatedDate;
  String? plcEndDate;
  String? plcWiesplInitiatedDate;
  String? plcWiesplEndDate;
  String? fineFilter;
  int? fineFilterLength;
  String? fineFilterWidth;
  int? fineFilterQuantity;
  String? ffInitiatedDate;
  String? ffEndDate;
  String? ffWiesplInitiatedDate;
  String? ffWiesplEndDate;
  int? preFilterLength;
  String? preFilterWidth;
  int? preFilterQuantity;
  String? pfInitiatedDate;
  String? pfEndDate;
  String? pfWiesplInitiatedDate;
  String? pfWiesplEndDate;
  int? epicFilterLength;
  String? epicFilterWidth;
  int? epicFilterQuantity;
  String? efInitiatedDate;
  String? efEndDate;
  String? efWiesplInitiatedDate;
  String? efWiesplEndDate;
  int? hepa1Length;
  String? hepa1Width;
  int? hepa1Quantity;
  String? hepa1InitiatedDate;
  String? hepa1EndDate;
  String? hepa1WiesplInitiatedDate;
  String? hepa1WiesplEndDate;
  String? hepa1Make;
  int? hepa2Length;
  String? hepa2Width;
  int? hepa2Quantity;
  String? hepa2InitiatedDate;
  String? hepa2EndDate;
  String? hepa2WiesplInitiatedDate;
  String? hepa2WiesplEndDate;
  String? hepa2Make;
  String? uv1Length;
  String? uv1Width;
  String? uv1Quantity;
  String? uv1InitiatedDate;
  String? uv1EndDate;
  String? uv1WiesplInitiatedDate;
  String? uv1WiesplEndDate;
  String? uv2Length;
  String? uv2Width;
  String? uv2Quantity;
  String? uv2InitiatedDate;
  String? uv2EndDate;
  String? uv2WiesplInitiatedDate;
  String? uv2WiesplEndDate;
  String? uv3Length;
  String? uv3Width;
  String? uv3Quantity;
  String? uv3InitiatedDate;
  String? uv3EndDate;
  String? uv3WiesplInitiatedDate;
  String? uv3WiesplEndDate;
  String? uv4Length;
  String? uv4Width;
  String? uv4Quantity;
  String? uv4InitiatedDate;
  String? uv4EndDate;
  String? uv4WiesplInitiatedDate;
  String? uv4WiesplEndDate;
  String? humidityAndTempController;
  String? cpInitiatedDate;
  String? cpEndDate;
  String? cpWiesplInitiatedDate;
  String? cpWiesplEndDate;
  String? dayTimeClock;
  String? dtcInitiatedDate;
  String? dtcEndDate;
  String? dtcWiesplInitiatedDate;
  String? dtcWiesplEndDate;
  String? timeElapsedClock;
  String? tecInitiatedDate;
  String? tecEndDate;
  String? tecWiesplInitiatedDate;
  String? tecWiesplEndDate;
  String? smps;
  String? smpsInitiatedDate;
  String? smpsEndDate;
  String? smpsWiesplInitiatedDate;
  String? smpsWiesplEndDate;
  String? timerCell;
  String? tcInitiatedDate;
  String? tcEndDate;
  String? tcWiesplInitiatedDate;
  String? tcWiesplEndDate;
  String? controlPanelDwg;
  String? ceillingPanel;
  String? wallPanel;
  String? wallPanelDescription;
  String? glassPanel;
  String? otImage;
  String? doorType1;
  String? dt1InitiatedDate;
  String? dt1EndDate;
  String? dt1WiesplInitiatedDate;
  String? dt1WiesplEndDate;
  String? doorType2;
  String? warranty;
  String? dt2InitiatedDate;
  String? dt2EndDate;
  String? dt2WiesplInitiatedDate;
  String? dt2WiesplEndDate;
  String? doorMaterial;
  String? towerBoltMake;
  String? doorCloseSpecs;
  String? doorCloseMake;
  String? airShower;
  String? airShowerSize;
  String? vinylFlooringOt;
  String? passBox;
  String? passBox2;
  String? automaticSurgicalScrub;
  String? assInitiatedDate;
  String? assEndDate;
  String? assWiesplInitiatedDate;
  String? assWiesplEndDate;
  String? manualSurgicalScrub;
  int? noOfBay;
  String? modeOfOperation;
  String? pendant;
  String? pendantType;
  String? steelCertification;
  String? ahuDoc;
  String? ductMaterial;
  String? ductInsulation;
  String? glass;
  String? temperatureSensor;
  String? humiditySensor;
  String? motorDoc;
  String? blowerDoc;
  String? vfd;
  String? coil;
  String? damper;
  String? heater;
  String? userManual;
  String? hepaFilter;
  String? fineFilterDoc;
  String? preFilter;
  String? pressureGuageMeter;
  String? copperPipe;
  String? otDrawing;
  String? ahuDrawing;
  String? flooringDrawing;
  String? coilSpecification;
  String? ductingDrawing;
  String? airValidationReport;
  String? pipingDrawing;
  String? controlPanelWiringDrawing;
  String? plenumDrawing;
  String? oduTds;
  int? siteId;
  int? createdBy;
  int? status;
  String? mpin;
  int? mpinChangeRequest;
  String? createdAt;
  String? updatedAt;
  String? requestType;
  String? systemStatus;
  String? activeTemperature;
  String? relativeHummidity;
  String? setHumidity;
  String? setTemperature;
  int? requestStatus;

  SystemListData(
      {this.id,
        this.name,
        this.systemNumber,
        this.typeOfSystem,
        this.temperatureRangeLowLimit,
        this.temperatureRangeHighLimit,
        this.rhRangeLowLimit,
        this.rhRangeHighLimit,
        this.dpRangeLowLimit,
        this.dpRangeHighLimit,
        this.plenumSize,
        this.shrmStatus,
        this.ahuMake,
        this.designCondition,
        this.airChangesPerHour,
        this.supplyCfm,
        this.dehumidifiedCfm,
        this.bypassCfm,
        this.freshAirCfm,
        this.actualAirChanges,
        this.coolingSystem,
        this.selectedCoilAdp,
        this.coilInletTemp,
        this.coilInletRh,
        this.cwsInletTemp,
        this.cwsOutletTemp,
        this.reheat,
        this.occupancy,
        this.equipmentLoat,
        this.derationPercentage,
        this.shrm,
        this.shrmValveUsed,
        this.shrmValue,
        this.shrmReheatCapacity,
        this.shrmInitiatedDate,
        this.shrmEndDate,
        this.shrmWiesplInitiatedDate,
        this.shrmWiesplEndDate,
        this.ahu,
        this.ahuWarranty,
        this.ahuInitiatedDate,
        this.ahuEndDate,
        this.ahuWiesplInitiatedDate,
        this.ahuWiesplEndDate,
        this.blower,
        this.blowerCurve,
        this.blowerType,
        this.blowerWarranty,
        this.blowerInitiatedDate,
        this.blowerEndDate,
        this.blowerWiesplInitiatedDate,
        this.blowerWiesplEndDate,
        this.bypassMotorizedDamper,
        this.bypassMotorizedDamperOpening,
        this.coilArea,
        this.coilDepth,
        this.coilMake,
        this.coilTonnage,
        this.coilWarranty,
        this.coilInitiatedDate,
        this.coilEndDate,
        this.coilWiesplInitiatedDate,
        this.coilWiesplEndDate,
        this.damperActuator,
        this.damperWarranty,
        this.damperInitiatedDate,
        this.damperEndDate,
        this.damperWiesplInitiatedDate,
        this.damperWiesplEndDate,
        this.designVfdFrequency,
        this.freshAirDamper,
        this.freshAirDamperOpening,
        this.motorBelt,
        this.motorBeltNumber,
        this.mbInitiatedDate,
        this.mbEndDate,
        this.mbWiesplInitiatedDate,
        this.mbWiesplEndDate,
        this.motorKw,
        this.motorMake,
        this.motorStatic,
        this.motor,
        this.motorType,
        this.motorInitiatedDate,
        this.motorEndDate,
        this.motorWiesplInitiatedDate,
        this.motorWiesplEndDate,
        this.motorPully,
        this.mpInitiatedDate,
        this.mpEndDate,
        this.mpWiesplInitiatedDate,
        this.mpWiesplEndDate,
        this.returnAirDamper,
        this.returnAirDamperOpening,
        this.vfdKw,
        this.vfdMake,
        this.adInitiatedDate,
        this.adEndDate,
        this.adWiesplInitiatedDate,
        this.adWiesplEndDate,
        this.exhaustFanCfm,
        this.noOfHeater1Banks,
        this.heater1Kw,
        this.heater1Type,
        this.heater1Warranty,
        this.heater1InitiatedDate,
        this.heater1EndDate,
        this.heater1WiesplInitiatedDate,
        this.heater1WiesplEndDate,
        this.noOfHeater2Banks,
        this.heater2Kw,
        this.heater2Type,
        this.heater2Warranty,
        this.heater2InitiatedDate,
        this.heater2EndDate,
        this.heater2WiesplInitiatedDate,
        this.heater2WiesplEndDate,
        this.noOfHeater3Banks,
        this.heater3Kw,
        this.heater3Type,
        this.heater3Warranty,
        this.heater3InitiatedDate,
        this.heater3EndDate,
        this.heater3WiesplInitiatedDate,
        this.heater3WiesplEndDate,
        this.noOfHeater4Banks,
        this.heater4Kw,
        this.heater4Type,
        this.heater4Warranty,
        this.heater4InitiatedDate,
        this.heater4EndDate,
        this.heater4WiesplInitiatedDate,
        this.heater4WiesplEndDate,
        this.acdPipeLength,
        this.acdOduTonnage,
        this.acdOduTonnageMake,
        this.acdOdutInitiatedDate,
        this.acdOdutEndDate,
        this.acdOdutWiesplInitiatedDate,
        this.acdOdutWiesplEndDate,
        this.acdOduCompressor,
        this.acdOduCompressorType,
        this.acdOduCompressorMake,
        this.acdOducInitiatedDate,
        this.acdOducEndDate,
        this.acdOducWiesplInitiatedDate,
        this.acdOducWiesplEndDate,
        this.acdOduCondenserFanMotor,
        this.acdOducfmInitiatedDate,
        this.acdOducfmEndDate,
        this.acdOducfmWiesplInitiatedDate,
        this.acdOducfmWiesplEndDate,
        this.acdOduCondenserFanBlade,
        this.acdOduCondenserFanBladeWarranty,
        this.acdOducfbInitiatedDate,
        this.acdOducfbEndDate,
        this.acdOducfbWiesplInitiatedDate,
        this.acdOducfbWiesplEndDate,
        this.acdExpensionDevice,
        this.acdEdInitiatedDate,
        this.acdEdEndDate,
        this.acdEdWiesplInitiatedDate,
        this.acdEdWiesplEndDate,
        this.acdDryerFilter,
        this.acdDfInitiatedDate,
        this.acdDfEndDate,
        this.acdDfWiesplInitiatedDate,
        this.acdDfWiesplEndDate,
        this.acdLpSwitch,
        this.acdLpsInitiatedDate,
        this.acdLpsEndDate,
        this.acdLpsWiesplInitiatedDate,
        this.acdLpsWiesplEndDate,
        this.acdHpSwitch,
        this.acdHpsInitiatedDate,
        this.acdHpsEndDate,
        this.acdHpsWiesplInitiatedDate,
        this.acdHpsWiesplEndDate,
        this.acdOduGas,
        this.acdOduGasQuantity,
        this.oduTonnage,
        this.oduTonnageMake,
        this.odutInitiatedDate,
        this.odutEndDate,
        this.odutWiesplInitiatedDate,
        this.odutWiesplEndDate,
        this.oduCompressor,
        this.oduCompressorType,
        this.oduCompressorMake,
        this.oducInitiatedDate,
        this.oducEndDate,
        this.oducWiesplInitiatedDate,
        this.oducWiesplEndDate,
        this.oduCondenserFanMotor,
        this.oducfmInitiatedDate,
        this.oducfmEndDate,
        this.oducfmWiesplInitiatedDate,
        this.oducfmWiesplEndDate,
        this.oduCondenserFanBlade,
        this.oducfbInitiatedDate,
        this.oducfbEndDate,
        this.oducfbWiesplInitiatedDate,
        this.oducfbWiesplEndDate,
        this.expensionDevice,
        this.edInitiatedDate,
        this.edEndDate,
        this.edWiesplInitiatedDate,
        this.edWiesplEndDate,
        this.dryerFilter,
        this.dfInitiatedDate,
        this.dfEndDate,
        this.dfWiesplInitiatedDate,
        this.dfWiesplEndDate,
        this.lpSwitch,
        this.lpsInitiatedDate,
        this.lpsEndDate,
        this.lpsWiesplInitiatedDate,
        this.lpsWiesplEndDate,
        this.hpSwitch,
        this.hpsInitiatedDate,
        this.hpsEndDate,
        this.hpsWiesplInitiatedDate,
        this.hpsWiesplEndDate,
        this.oduGas,
        this.oduGasQuantity,
        this.fireDamper,
        this.fireDamperAccuator,
        this.thermalExpansionDevice,
        this.expansionValveOrifice,
        this.thyristor,
        this.thyristorInitiatedDate,
        this.thyristorEndDate,
        this.thyristorWiesplInitiatedDate,
        this.thyristorWiesplEndDate,
        this.plc,
        this.plcInitiatedDate,
        this.plcEndDate,
        this.plcWiesplInitiatedDate,
        this.plcWiesplEndDate,
        this.fineFilter,
        this.fineFilterLength,
        this.fineFilterWidth,
        this.fineFilterQuantity,
        this.ffInitiatedDate,
        this.ffEndDate,
        this.ffWiesplInitiatedDate,
        this.ffWiesplEndDate,
        this.preFilterLength,
        this.preFilterWidth,
        this.preFilterQuantity,
        this.pfInitiatedDate,
        this.pfEndDate,
        this.pfWiesplInitiatedDate,
        this.pfWiesplEndDate,
        this.epicFilterLength,
        this.epicFilterWidth,
        this.epicFilterQuantity,
        this.efInitiatedDate,
        this.efEndDate,
        this.efWiesplInitiatedDate,
        this.efWiesplEndDate,
        this.hepa1Length,
        this.hepa1Width,
        this.hepa1Quantity,
        this.hepa1InitiatedDate,
        this.hepa1EndDate,
        this.hepa1WiesplInitiatedDate,
        this.hepa1WiesplEndDate,
        this.hepa1Make,
        this.hepa2Length,
        this.hepa2Width,
        this.hepa2Quantity,
        this.hepa2InitiatedDate,
        this.hepa2EndDate,
        this.hepa2WiesplInitiatedDate,
        this.hepa2WiesplEndDate,
        this.hepa2Make,
        this.uv1Length,
        this.uv1Width,
        this.uv1Quantity,
        this.uv1InitiatedDate,
        this.uv1EndDate,
        this.uv1WiesplInitiatedDate,
        this.uv1WiesplEndDate,
        this.uv2Length,
        this.uv2Width,
        this.uv2Quantity,
        this.uv2InitiatedDate,
        this.uv2EndDate,
        this.uv2WiesplInitiatedDate,
        this.uv2WiesplEndDate,
        this.uv3Length,
        this.uv3Width,
        this.uv3Quantity,
        this.uv3InitiatedDate,
        this.uv3EndDate,
        this.uv3WiesplInitiatedDate,
        this.uv3WiesplEndDate,
        this.uv4Length,
        this.uv4Width,
        this.uv4Quantity,
        this.uv4InitiatedDate,
        this.uv4EndDate,
        this.uv4WiesplInitiatedDate,
        this.uv4WiesplEndDate,
        this.humidityAndTempController,
        this.cpInitiatedDate,
        this.cpEndDate,
        this.cpWiesplInitiatedDate,
        this.cpWiesplEndDate,
        this.dayTimeClock,
        this.dtcInitiatedDate,
        this.dtcEndDate,
        this.dtcWiesplInitiatedDate,
        this.dtcWiesplEndDate,
        this.timeElapsedClock,
        this.tecInitiatedDate,
        this.tecEndDate,
        this.tecWiesplInitiatedDate,
        this.tecWiesplEndDate,
        this.smps,
        this.smpsInitiatedDate,
        this.smpsEndDate,
        this.smpsWiesplInitiatedDate,
        this.smpsWiesplEndDate,
        this.timerCell,
        this.tcInitiatedDate,
        this.tcEndDate,
        this.tcWiesplInitiatedDate,
        this.tcWiesplEndDate,
        this.controlPanelDwg,
        this.ceillingPanel,
        this.wallPanel,
        this.wallPanelDescription,
        this.glassPanel,
        this.otImage,
        this.doorType1,
        this.dt1InitiatedDate,
        this.dt1EndDate,
        this.dt1WiesplInitiatedDate,
        this.dt1WiesplEndDate,
        this.doorType2,
        this.warranty,
        this.dt2InitiatedDate,
        this.dt2EndDate,
        this.dt2WiesplInitiatedDate,
        this.dt2WiesplEndDate,
        this.doorMaterial,
        this.towerBoltMake,
        this.doorCloseSpecs,
        this.doorCloseMake,
        this.airShower,
        this.airShowerSize,
        this.vinylFlooringOt,
        this.passBox,
        this.passBox2,
        this.automaticSurgicalScrub,
        this.assInitiatedDate,
        this.assEndDate,
        this.assWiesplInitiatedDate,
        this.assWiesplEndDate,
        this.manualSurgicalScrub,
        this.noOfBay,
        this.modeOfOperation,
        this.pendant,
        this.pendantType,
        this.steelCertification,
        this.ahuDoc,
        this.ductMaterial,
        this.ductInsulation,
        this.glass,
        this.temperatureSensor,
        this.humiditySensor,
        this.motorDoc,
        this.blowerDoc,
        this.vfd,
        this.coil,
        this.damper,
        this.heater,
        this.userManual,
        this.hepaFilter,
        this.fineFilterDoc,
        this.preFilter,
        this.pressureGuageMeter,
        this.copperPipe,
        this.otDrawing,
        this.ahuDrawing,
        this.flooringDrawing,
        this.coilSpecification,
        this.ductingDrawing,
        this.airValidationReport,
        this.pipingDrawing,
        this.controlPanelWiringDrawing,
        this.plenumDrawing,
        this.oduTds,
        this.siteId,
        this.createdBy,
        this.status,
        this.mpin,
        this.mpinChangeRequest,
        this.createdAt,
        this.updatedAt,
        this.requestType,
        this.systemStatus,
        this.activeTemperature,
        this.relativeHummidity,
        this.setTemperature,
        this.requestStatus
      });

  SystemListData.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    name = json['name'] ?? '';
    systemNumber = json['system_number'] ?? '';
    typeOfSystem = json['type_of_system'];
    temperatureRangeLowLimit = json['temperature_range_low_limit'] ?? '0';
    temperatureRangeHighLimit = json['temperature_range_high_limit']??'0';
    rhRangeLowLimit = json['rh_range_low_limit']?? '0';
    rhRangeHighLimit = json['rh_range_high_limit']??'100';
    dpRangeLowLimit = json['dp_range_low_limit'];
    dpRangeHighLimit = json['dp_range_high_limit'];
    plenumSize = json['plenum_size'];
    shrmStatus = json['shrm_status'];
    ahuMake = json['ahu_make'];
    designCondition = json['design_condition'];
    airChangesPerHour = json['air_changes_per_hour'];
    supplyCfm = json['supply_cfm'];
    dehumidifiedCfm = json['dehumidified_cfm'];
    bypassCfm = json['bypass_cfm'];
    freshAirCfm = json['fresh_air_cfm'];
    actualAirChanges = json['actual_air_changes'];
    coolingSystem = json['cooling_system'];
    selectedCoilAdp = json['selected_coil_adp'];
    coilInletTemp = json['coil_inlet_temp'];
    coilInletRh = json['coil_inlet_rh'];
    cwsInletTemp = json['cws_inlet_temp'];
    cwsOutletTemp = json['cws_outlet_temp'];
    reheat = json['reheat'];
    occupancy = json['occupancy'];
    equipmentLoat = json['equipment_loat'];
    derationPercentage = json['deration_percentage'];
    shrm = json['shrm'];
    shrmValveUsed = json['shrm_valve_used'];
    shrmValue = json['shrm_value'];
    shrmReheatCapacity = json['shrm_reheat_capacity'];
    shrmInitiatedDate = json['shrm_initiated_date'];
    shrmEndDate = json['shrm_end_date'];
    shrmWiesplInitiatedDate = json['shrm_wiespl_initiated_date'];
    shrmWiesplEndDate = json['shrm_wiespl_end_date'];
    ahu = json['ahu'];
    ahuWarranty = json['ahu_warranty'];
    ahuInitiatedDate = json['ahu_initiated_date'];
    ahuEndDate = json['ahu_end_date'];
    ahuWiesplInitiatedDate = json['ahu_wiespl_initiated_date'];
    ahuWiesplEndDate = json['ahu_wiespl_end_date'];
    blower = json['blower'];
    blowerCurve = json['blower_curve'];
    blowerType = json['blower_type'];
    blowerWarranty = json['blower_warranty'];
    blowerInitiatedDate = json['blower_initiated_date'];
    blowerEndDate = json['blower_end_date'];
    blowerWiesplInitiatedDate = json['blower_wiespl_initiated_date'];
    blowerWiesplEndDate = json['blower_wiespl_end_date'];
    bypassMotorizedDamper = json['bypass_motorized_damper'];
    bypassMotorizedDamperOpening = json['bypass_motorized_damper_opening'];
    coilArea = json['coil_area'];
    coilDepth = json['coil_depth'];
    coilMake = json['coil_make'];
    coilTonnage = json['coil_tonnage'];
    coilWarranty = json['coil_warranty'];
    coilInitiatedDate = json['coil_initiated_date'];
    coilEndDate = json['coil_end_date'];
    coilWiesplInitiatedDate = json['coil_wiespl_initiated_date'];
    coilWiesplEndDate = json['coil_wiespl_end_date'];
    damperActuator = json['damper_actuator'];
    damperWarranty = json['damper_warranty'];
    damperInitiatedDate = json['damper_initiated_date'];
    damperEndDate = json['damper_end_date'];
    damperWiesplInitiatedDate = json['damper_wiespl_initiated_date'];
    damperWiesplEndDate = json['damper_wiespl_end_date'];
    designVfdFrequency = json['design_vfd_frequency'];
    freshAirDamper = json['fresh_air_damper'];
    freshAirDamperOpening = json['fresh_air_damper_opening'];
    motorBelt = json['motor_belt'];
    motorBeltNumber = json['motor_belt_number'];
    mbInitiatedDate = json['mb_initiated_date'];
    mbEndDate = json['mb_end_date'];
    mbWiesplInitiatedDate = json['mb_wiespl_initiated_date'];
    mbWiesplEndDate = json['mb_wiespl_end_date'];
    motorKw = json['motor_kw'];
    motorMake = json['motor_make'];
    motorStatic = json['motor_static'];
    motor = json['motor'];
    motorType = json['motor_type'];
    motorInitiatedDate = json['motor_initiated_date'];
    motorEndDate = json['motor_end_date'];
    motorWiesplInitiatedDate = json['motor_wiespl_initiated_date'];
    motorWiesplEndDate = json['motor_wiespl_end_date'];
    motorPully = json['motor_pully'];
    mpInitiatedDate = json['mp_initiated_date'];
    mpEndDate = json['mp_end_date'];
    mpWiesplInitiatedDate = json['mp_wiespl_initiated_date'];
    mpWiesplEndDate = json['mp_wiespl_end_date'];
    returnAirDamper = json['return_air_damper'];
    returnAirDamperOpening = json['return_air_damper_opening'];
    vfdKw = json['vfd_kw'];
    vfdMake = json['vfd_make'];
    adInitiatedDate = json['ad_initiated_date'];
    adEndDate = json['ad_end_date'];
    adWiesplInitiatedDate = json['ad_wiespl_initiated_date'];
    adWiesplEndDate = json['ad_wiespl_end_date'];
    exhaustFanCfm = json['exhaust_fan_cfm'];
    noOfHeater1Banks = json['no_of_heater1_banks'];
    heater1Kw = json['heater1_kw'];
    heater1Type = json['heater1_type'];
    heater1Warranty = json['heater1_warranty'];
    heater1InitiatedDate = json['heater1_initiated_date'];
    heater1EndDate = json['heater1_end_date'];
    heater1WiesplInitiatedDate = json['heater1_wiespl_initiated_date'];
    heater1WiesplEndDate = json['heater1_wiespl_end_date'];
    noOfHeater2Banks = json['no_of_heater2_banks'];
    heater2Kw = json['heater2_kw'];
    heater2Type = json['heater2_type'];
    heater2Warranty = json['heater2_warranty'];
    heater2InitiatedDate = json['heater2_initiated_date'];
    heater2EndDate = json['heater2_end_date'];
    heater2WiesplInitiatedDate = json['heater2_wiespl_initiated_date'];
    heater2WiesplEndDate = json['heater2_wiespl_end_date'];
    noOfHeater3Banks = json['no_of_heater3_banks'];
    heater3Kw = json['heater3_kw'];
    heater3Type = json['heater3_type'];
    heater3Warranty = json['heater3_warranty'];
    heater3InitiatedDate = json['heater3_initiated_date'];
    heater3EndDate = json['heater3_end_date'];
    heater3WiesplInitiatedDate = json['heater3_wiespl_initiated_date'];
    heater3WiesplEndDate = json['heater3_wiespl_end_date'];
    noOfHeater4Banks = json['no_of_heater4_banks'];
    heater4Kw = json['heater4_kw'];
    heater4Type = json['heater4_type'];
    heater4Warranty = json['heater4_warranty'];
    heater4InitiatedDate = json['heater4_initiated_date'];
    heater4EndDate = json['heater4_end_date'];
    heater4WiesplInitiatedDate = json['heater4_wiespl_initiated_date'];
    heater4WiesplEndDate = json['heater4_wiespl_end_date'];
    acdPipeLength = json['acd_pipe_length'];
    acdOduTonnage = json['acd_odu_tonnage'];
    acdOduTonnageMake = json['acd_odu_tonnage_make'];
    acdOdutInitiatedDate = json['acd_odut_initiated_date'];
    acdOdutEndDate = json['acd_odut_end_date'];
    acdOdutWiesplInitiatedDate = json['acd_odut_wiespl_initiated_date'];
    acdOdutWiesplEndDate = json['acd_odut_wiespl_end_date'];
    acdOduCompressor = json['acd_odu_compressor'];
    acdOduCompressorType = json['acd_odu_compressor_type'];
    acdOduCompressorMake = json['acd_odu_compressor_make'];
    acdOducInitiatedDate = json['acd_oduc_initiated_date'];
    acdOducEndDate = json['acd_oduc_end_date'];
    acdOducWiesplInitiatedDate = json['acd_oduc_wiespl_initiated_date'];
    acdOducWiesplEndDate = json['acd_oduc_wiespl_end_date'];
    acdOduCondenserFanMotor = json['acd_odu_condenser_fan_motor'];
    acdOducfmInitiatedDate = json['acd_oducfm_initiated_date'];
    acdOducfmEndDate = json['acd_oducfm_end_date'];
    acdOducfmWiesplInitiatedDate = json['acd_oducfm_wiespl_initiated_date'];
    acdOducfmWiesplEndDate = json['acd_oducfm_wiespl_end_date'];
    acdOduCondenserFanBlade = json['acd_odu_condenser_fan_blade'];
    acdOduCondenserFanBladeWarranty =
    json['acd_odu_condenser_fan_blade_warranty'];
    acdOducfbInitiatedDate = json['acd_oducfb_initiated_date'];
    acdOducfbEndDate = json['acd_oducfb_end_date'];
    acdOducfbWiesplInitiatedDate = json['acd_oducfb_wiespl_initiated_date'];
    acdOducfbWiesplEndDate = json['acd_oducfb_wiespl_end_date'];
    acdExpensionDevice = json['acd_expension_device'];
    acdEdInitiatedDate = json['acd_ed_initiated_date'];
    acdEdEndDate = json['acd_ed_end_date'];
    acdEdWiesplInitiatedDate = json['acd_ed_wiespl_initiated_date'];
    acdEdWiesplEndDate = json['acd_ed_wiespl_end_date'];
    acdDryerFilter = json['acd_dryer_filter'];
    acdDfInitiatedDate = json['acd_df_initiated_date'];
    acdDfEndDate = json['acd_df_end_date'];
    acdDfWiesplInitiatedDate = json['acd_df_wiespl_initiated_date'];
    acdDfWiesplEndDate = json['acd_df_wiespl_end_date'];
    acdLpSwitch = json['acd_lp_switch'];
    acdLpsInitiatedDate = json['acd_lps_initiated_date'];
    acdLpsEndDate = json['acd_lps_end_date'];
    acdLpsWiesplInitiatedDate = json['acd_lps_wiespl_initiated_date'];
    acdLpsWiesplEndDate = json['acd_lps_wiespl_end_date'];
    acdHpSwitch = json['acd_hp_switch'];
    acdHpsInitiatedDate = json['acd_hps_initiated_date'];
    acdHpsEndDate = json['acd_hps_end_date'];
    acdHpsWiesplInitiatedDate = json['acd_hps_wiespl_initiated_date'];
    acdHpsWiesplEndDate = json['acd_hps_wiespl_end_date'];
    acdOduGas = json['acd_odu_gas'];
    acdOduGasQuantity = json['acd_odu_gas_quantity'];
    oduTonnage = json['odu_tonnage'];
    oduTonnageMake = json['odu_tonnage_make'];
    odutInitiatedDate = json['odut_initiated_date'];
    odutEndDate = json['odut_end_date'];
    odutWiesplInitiatedDate = json['odut_wiespl_initiated_date'];
    odutWiesplEndDate = json['odut_wiespl_end_date'];
    oduCompressor = json['odu_compressor'];
    oduCompressorType = json['odu_compressor_type'];
    oduCompressorMake = json['odu_compressor_make'];
    oducInitiatedDate = json['oduc_initiated_date'];
    oducEndDate = json['oduc_end_date'];
    oducWiesplInitiatedDate = json['oduc_wiespl_initiated_date'];
    oducWiesplEndDate = json['oduc_wiespl_end_date'];
    oduCondenserFanMotor = json['odu_condenser_fan_motor'];
    oducfmInitiatedDate = json['oducfm_initiated_date'];
    oducfmEndDate = json['oducfm_end_date'];
    oducfmWiesplInitiatedDate = json['oducfm_wiespl_initiated_date'];
    oducfmWiesplEndDate = json['oducfm_wiespl_end_date'];
    oduCondenserFanBlade = json['odu_condenser_fan_blade'];
    oducfbInitiatedDate = json['oducfb_initiated_date'];
    oducfbEndDate = json['oducfb_end_date'];
    oducfbWiesplInitiatedDate = json['oducfb_wiespl_initiated_date'];
    oducfbWiesplEndDate = json['oducfb_wiespl_end_date'];
    expensionDevice = json['expension_device'];
    edInitiatedDate = json['ed_initiated_date'];
    edEndDate = json['ed_end_date'];
    edWiesplInitiatedDate = json['ed_wiespl_initiated_date'];
    edWiesplEndDate = json['ed_wiespl_end_date'];
    dryerFilter = json['dryer_filter'];
    dfInitiatedDate = json['df_initiated_date'];
    dfEndDate = json['df_end_date'];
    dfWiesplInitiatedDate = json['df_wiespl_initiated_date'];
    dfWiesplEndDate = json['df_wiespl_end_date'];
    lpSwitch = json['lp_switch'];
    lpsInitiatedDate = json['lps_initiated_date'];
    lpsEndDate = json['lps_end_date'];
    lpsWiesplInitiatedDate = json['lps_wiespl_initiated_date'];
    lpsWiesplEndDate = json['lps_wiespl_end_date'];
    hpSwitch = json['hp_switch'];
    hpsInitiatedDate = json['hps_initiated_date'];
    hpsEndDate = json['hps_end_date'];
    hpsWiesplInitiatedDate = json['hps_wiespl_initiated_date'];
    hpsWiesplEndDate = json['hps_wiespl_end_date'];
    oduGas = json['odu_gas'];
    oduGasQuantity = json['odu_gas_quantity'];
    fireDamper = json['fire_damper'];
    fireDamperAccuator = json['fire_damper_accuator'];
    thermalExpansionDevice = json['thermal_expansion_device'];
    expansionValveOrifice = json['expansion_valve_orifice'];
    thyristor = json['thyristor'];
    thyristorInitiatedDate = json['thyristor_initiated_date'];
    thyristorEndDate = json['thyristor_end_date'];
    thyristorWiesplInitiatedDate = json['thyristor_wiespl_initiated_date'];
    thyristorWiesplEndDate = json['thyristor_wiespl_end_date'];
    plc = json['plc'];
    plcInitiatedDate = json['plc_initiated_date'];
    plcEndDate = json['plc_end_date'];
    plcWiesplInitiatedDate = json['plc_wiespl_initiated_date'];
    plcWiesplEndDate = json['plc_wiespl_end_date'];
    fineFilter = json['fine_filter'];
    fineFilterLength = json['fine_filter_length'];
    fineFilterWidth = json['fine_filter_width'];
    fineFilterQuantity = json['fine_filter_quantity'];
    ffInitiatedDate = json['ff_initiated_date'];
    ffEndDate = json['ff_end_date'];
    ffWiesplInitiatedDate = json['ff_wiespl_initiated_date'];
    ffWiesplEndDate = json['ff_wiespl_end_date'];
    preFilterLength = json['pre_filter_length'];
    preFilterWidth = json['pre_filter_width'];
    preFilterQuantity = json['pre_filter_quantity'];
    pfInitiatedDate = json['pf_initiated_date'];
    pfEndDate = json['pf_end_date'];
    pfWiesplInitiatedDate = json['pf_wiespl_initiated_date'];
    pfWiesplEndDate = json['pf_wiespl_end_date'];
    epicFilterLength = json['epic_filter_length'];
    epicFilterWidth = json['epic_filter_width'];
    epicFilterQuantity = json['epic_filter_quantity'];
    efInitiatedDate = json['ef_initiated_date'];
    efEndDate = json['ef_end_date'];
    efWiesplInitiatedDate = json['ef_wiespl_initiated_date'];
    efWiesplEndDate = json['ef_wiespl_end_date'];
    hepa1Length = json['hepa1_length'];
    hepa1Width = json['hepa1_width'];
    hepa1Quantity = json['hepa1_quantity'];
    hepa1InitiatedDate = json['hepa1_initiated_date'];
    hepa1EndDate = json['hepa1_end_date'];
    hepa1WiesplInitiatedDate = json['hepa1_wiespl_initiated_date'];
    hepa1WiesplEndDate = json['hepa1_wiespl_end_date'];
    hepa1Make = json['hepa1_make'];
    hepa2Length = json['hepa2_length'];
    hepa2Width = json['hepa2_width'];
    hepa2Quantity = json['hepa2_quantity'];
    hepa2InitiatedDate = json['hepa2_initiated_date'];
    hepa2EndDate = json['hepa2_end_date'];
    hepa2WiesplInitiatedDate = json['hepa2_wiespl_initiated_date'];
    hepa2WiesplEndDate = json['hepa2_wiespl_end_date'];
    hepa2Make = json['hepa2_make'];
    uv1Length = json['uv1_length'];
    uv1Width = json['uv1_width'];
    uv1Quantity = json['uv1_quantity'];
    uv1InitiatedDate = json['uv1_initiated_date'];
    uv1EndDate = json['uv1_end_date'];
    uv1WiesplInitiatedDate = json['uv1_wiespl_initiated_date'];
    uv1WiesplEndDate = json['uv1_wiespl_end_date'];
    uv2Length = json['uv2_length'];
    uv2Width = json['uv2_width'];
    uv2Quantity = json['uv2_quantity'];
    uv2InitiatedDate = json['uv2_initiated_date'];
    uv2EndDate = json['uv2_end_date'];
    uv2WiesplInitiatedDate = json['uv2_wiespl_initiated_date'];
    uv2WiesplEndDate = json['uv2_wiespl_end_date'];
    uv3Length = json['uv3_length'];
    uv3Width = json['uv3_width'];
    uv3Quantity = json['uv3_quantity'];
    uv3InitiatedDate = json['uv3_initiated_date'];
    uv3EndDate = json['uv3_end_date'];
    uv3WiesplInitiatedDate = json['uv3_wiespl_initiated_date'];
    uv3WiesplEndDate = json['uv3_wiespl_end_date'];
    uv4Length = json['uv4_length'];
    uv4Width = json['uv4_width'];
    uv4Quantity = json['uv4_quantity'];
    uv4InitiatedDate = json['uv4_initiated_date'];
    uv4EndDate = json['uv4_end_date'];
    uv4WiesplInitiatedDate = json['uv4_wiespl_initiated_date'];
    uv4WiesplEndDate = json['uv4_wiespl_end_date'];
    humidityAndTempController = json['humidity_and_temp_controller'];
    cpInitiatedDate = json['cp_initiated_date'];
    cpEndDate = json['cp_end_date'];
    cpWiesplInitiatedDate = json['cp_wiespl_initiated_date'];
    cpWiesplEndDate = json['cp_wiespl_end_date'];
    dayTimeClock = json['day_time_clock'];
    dtcInitiatedDate = json['dtc_initiated_date'];
    dtcEndDate = json['dtc_end_date'];
    dtcWiesplInitiatedDate = json['dtc_wiespl_initiated_date'];
    dtcWiesplEndDate = json['dtc_wiespl_end_date'];
    timeElapsedClock = json['time_elapsed_clock'];
    tecInitiatedDate = json['tec_initiated_date'];
    tecEndDate = json['tec_end_date'];
    tecWiesplInitiatedDate = json['tec_wiespl_initiated_date'];
    tecWiesplEndDate = json['tec_wiespl_end_date'];
    smps = json['smps'];
    smpsInitiatedDate = json['smps_initiated_date'];
    smpsEndDate = json['smps_end_date'];
    smpsWiesplInitiatedDate = json['smps_wiespl_initiated_date'];
    smpsWiesplEndDate = json['smps_wiespl_end_date'];
    timerCell = json['timer_cell'];
    tcInitiatedDate = json['tc_initiated_date'];
    tcEndDate = json['tc_end_date'];
    tcWiesplInitiatedDate = json['tc_wiespl_initiated_date'];
    tcWiesplEndDate = json['tc_wiespl_end_date'];
    controlPanelDwg = json['control_panel_dwg'];
    ceillingPanel = json['ceilling_panel'];
    wallPanel = json['wall_panel'];
    wallPanelDescription = json['wall_panel_description'];
    glassPanel = json['glass_panel'];
    otImage = json['ot_image'];
    doorType1 = json['door_type1'];
    dt1InitiatedDate = json['dt1_initiated_date'];
    dt1EndDate = json['dt1_end_date'];
    dt1WiesplInitiatedDate = json['dt1_wiespl_initiated_date'];
    dt1WiesplEndDate = json['dt1_wiespl_end_date'];
    doorType2 = json['door_type2'];
    warranty = json['warranty'];
    dt2InitiatedDate = json['dt2_initiated_date'];
    dt2EndDate = json['dt2_end_date'];
    dt2WiesplInitiatedDate = json['dt2_wiespl_initiated_date'];
    dt2WiesplEndDate = json['dt2_wiespl_end_date'];
    doorMaterial = json['door_material'];
    towerBoltMake = json['tower_bolt_make'];
    doorCloseSpecs = json['door_close_specs'];
    doorCloseMake = json['door_close_make'];
    airShower = json['air_shower'];
    airShowerSize = json['air_shower_size'];
    vinylFlooringOt = json['vinyl_flooring_ot'];
    passBox = json['pass_box'];
    passBox2 = json['pass_box2'];
    automaticSurgicalScrub = json['automatic_surgical_scrub'];
    assInitiatedDate = json['ass_initiated_date'];
    assEndDate = json['ass_end_date'];
    assWiesplInitiatedDate = json['ass_wiespl_initiated_date'];
    assWiesplEndDate = json['ass_wiespl_end_date'];
    manualSurgicalScrub = json['manual_surgical_scrub'];
    noOfBay = json['no_of_bay'];
    modeOfOperation = json['mode_of_operation'];
    pendant = json['pendant'];
    pendantType = json['pendant_type'];
    steelCertification = json['steel_certification'];
    ahuDoc = json['ahu_doc'];
    ductMaterial = json['duct_material'];
    ductInsulation = json['duct_insulation'];
    glass = json['glass'];
    temperatureSensor = json['temperature_sensor'];
    humiditySensor = json['humidity_sensor'];
    motorDoc = json['motor_doc'];
    blowerDoc = json['blower_doc'];
    vfd = json['vfd'];
    coil = json['coil'];
    damper = json['damper'];
    heater = json['heater'];
    userManual = json['user_manual'];
    hepaFilter = json['hepa_filter'];
    fineFilterDoc = json['fine_filter_doc'];
    preFilter = json['pre_filter'];
    pressureGuageMeter = json['pressure_guage_meter'];
    copperPipe = json['copper_pipe'];
    otDrawing = json['ot_drawing'];
    ahuDrawing = json['ahu_drawing'];
    flooringDrawing = json['flooring_drawing'];
    coilSpecification = json['coil_specification'];
    ductingDrawing = json['ducting_drawing'];
    airValidationReport = json['air_validation_report'];
    pipingDrawing = json['piping_drawing'];
    controlPanelWiringDrawing = json['control_panel_wiring_drawing'];
    plenumDrawing = json['plenum_drawing'];
    oduTds = json['odu_tds'];
    siteId = json['site_id'];
    createdBy = json['created_by'];
    status = json['status'];
    mpin = json['mpin'];
    mpinChangeRequest = json['mpin_change_request'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    requestType = json['request_type'] ?? '';
    systemStatus = json['system_status'] ?? 'OFF';
    activeTemperature = json['active_temperature'] ?? '0';
    relativeHummidity = json['relative_hummidity'] ?? '0';
    setHumidity = json['set_humidity'] ?? '0';
    setTemperature = json['set_temperature'] ?? '0';
    requestStatus = json['request_status']??-1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['system_number'] = systemNumber;
    data['type_of_system'] = typeOfSystem;
    data['temperature_range_low_limit'] = temperatureRangeLowLimit;
    data['temperature_range_high_limit'] = temperatureRangeHighLimit;
    data['rh_range_low_limit'] = rhRangeLowLimit;
    data['rh_range_high_limit'] = rhRangeHighLimit;
    data['dp_range_low_limit'] = dpRangeLowLimit;
    data['dp_range_high_limit'] = dpRangeHighLimit;
    data['plenum_size'] = plenumSize;
    data['shrm_status'] = shrmStatus;
    data['ahu_make'] = ahuMake;
    data['design_condition'] = designCondition;
    data['air_changes_per_hour'] = airChangesPerHour;
    data['supply_cfm'] = supplyCfm;
    data['dehumidified_cfm'] = dehumidifiedCfm;
    data['bypass_cfm'] = bypassCfm;
    data['fresh_air_cfm'] = freshAirCfm;
    data['actual_air_changes'] = actualAirChanges;
    data['cooling_system'] = coolingSystem;
    data['selected_coil_adp'] = selectedCoilAdp;
    data['coil_inlet_temp'] = coilInletTemp;
    data['coil_inlet_rh'] = coilInletRh;
    data['cws_inlet_temp'] = cwsInletTemp;
    data['cws_outlet_temp'] = cwsOutletTemp;
    data['reheat'] = reheat;
    data['occupancy'] = occupancy;
    data['equipment_loat'] = equipmentLoat;
    data['deration_percentage'] = derationPercentage;
    data['shrm'] = shrm;
    data['shrm_valve_used'] = shrmValveUsed;
    data['shrm_value'] = shrmValue;
    data['shrm_reheat_capacity'] = shrmReheatCapacity;
    data['shrm_initiated_date'] = shrmInitiatedDate;
    data['shrm_end_date'] = shrmEndDate;
    data['shrm_wiespl_initiated_date'] = shrmWiesplInitiatedDate;
    data['shrm_wiespl_end_date'] = shrmWiesplEndDate;
    data['ahu'] = ahu;
    data['ahu_warranty'] = ahuWarranty;
    data['ahu_initiated_date'] = ahuInitiatedDate;
    data['ahu_end_date'] = ahuEndDate;
    data['ahu_wiespl_initiated_date'] = ahuWiesplInitiatedDate;
    data['ahu_wiespl_end_date'] = ahuWiesplEndDate;
    data['blower'] = blower;
    data['blower_curve'] = blowerCurve;
    data['blower_type'] = blowerType;
    data['blower_warranty'] = blowerWarranty;
    data['blower_initiated_date'] = blowerInitiatedDate;
    data['blower_end_date'] = blowerEndDate;
    data['blower_wiespl_initiated_date'] = blowerWiesplInitiatedDate;
    data['blower_wiespl_end_date'] = blowerWiesplEndDate;
    data['bypass_motorized_damper'] = bypassMotorizedDamper;
    data['bypass_motorized_damper_opening'] = bypassMotorizedDamperOpening;
    data['coil_area'] = coilArea;
    data['coil_depth'] = coilDepth;
    data['coil_make'] = coilMake;
    data['coil_tonnage'] = coilTonnage;
    data['coil_warranty'] = coilWarranty;
    data['coil_initiated_date'] = coilInitiatedDate;
    data['coil_end_date'] = coilEndDate;
    data['coil_wiespl_initiated_date'] = coilWiesplInitiatedDate;
    data['coil_wiespl_end_date'] = coilWiesplEndDate;
    data['damper_actuator'] = damperActuator;
    data['damper_warranty'] = damperWarranty;
    data['damper_initiated_date'] = damperInitiatedDate;
    data['damper_end_date'] = damperEndDate;
    data['damper_wiespl_initiated_date'] = damperWiesplInitiatedDate;
    data['damper_wiespl_end_date'] = damperWiesplEndDate;
    data['design_vfd_frequency'] = designVfdFrequency;
    data['fresh_air_damper'] = freshAirDamper;
    data['fresh_air_damper_opening'] = freshAirDamperOpening;
    data['motor_belt'] = motorBelt;
    data['motor_belt_number'] = motorBeltNumber;
    data['mb_initiated_date'] = mbInitiatedDate;
    data['mb_end_date'] = mbEndDate;
    data['mb_wiespl_initiated_date'] = mbWiesplInitiatedDate;
    data['mb_wiespl_end_date'] = mbWiesplEndDate;
    data['motor_kw'] = motorKw;
    data['motor_make'] = motorMake;
    data['motor_static'] = motorStatic;
    data['motor'] = motor;
    data['motor_type'] = motorType;
    data['motor_initiated_date'] = motorInitiatedDate;
    data['motor_end_date'] = motorEndDate;
    data['motor_wiespl_initiated_date'] = motorWiesplInitiatedDate;
    data['motor_wiespl_end_date'] = motorWiesplEndDate;
    data['motor_pully'] = motorPully;
    data['mp_initiated_date'] = mpInitiatedDate;
    data['mp_end_date'] = mpEndDate;
    data['mp_wiespl_initiated_date'] = mpWiesplInitiatedDate;
    data['mp_wiespl_end_date'] = mpWiesplEndDate;
    data['return_air_damper'] = returnAirDamper;
    data['return_air_damper_opening'] = returnAirDamperOpening;
    data['vfd_kw'] = vfdKw;
    data['vfd_make'] = vfdMake;
    data['ad_initiated_date'] = adInitiatedDate;
    data['ad_end_date'] = adEndDate;
    data['ad_wiespl_initiated_date'] = adWiesplInitiatedDate;
    data['ad_wiespl_end_date'] = adWiesplEndDate;
    data['exhaust_fan_cfm'] = exhaustFanCfm;
    data['no_of_heater1_banks'] = noOfHeater1Banks;
    data['heater1_kw'] = heater1Kw;
    data['heater1_type'] = heater1Type;
    data['heater1_warranty'] = heater1Warranty;
    data['heater1_initiated_date'] = heater1InitiatedDate;
    data['heater1_end_date'] = heater1EndDate;
    data['heater1_wiespl_initiated_date'] = heater1WiesplInitiatedDate;
    data['heater1_wiespl_end_date'] = heater1WiesplEndDate;
    data['no_of_heater2_banks'] = noOfHeater2Banks;
    data['heater2_kw'] = heater2Kw;
    data['heater2_type'] = heater2Type;
    data['heater2_warranty'] = heater2Warranty;
    data['heater2_initiated_date'] = heater2InitiatedDate;
    data['heater2_end_date'] = heater2EndDate;
    data['heater2_wiespl_initiated_date'] = heater2WiesplInitiatedDate;
    data['heater2_wiespl_end_date'] = heater2WiesplEndDate;
    data['no_of_heater3_banks'] = noOfHeater3Banks;
    data['heater3_kw'] = heater3Kw;
    data['heater3_type'] = heater3Type;
    data['heater3_warranty'] = heater3Warranty;
    data['heater3_initiated_date'] = heater3InitiatedDate;
    data['heater3_end_date'] = heater3EndDate;
    data['heater3_wiespl_initiated_date'] = heater3WiesplInitiatedDate;
    data['heater3_wiespl_end_date'] = heater3WiesplEndDate;
    data['no_of_heater4_banks'] = noOfHeater4Banks;
    data['heater4_kw'] = heater4Kw;
    data['heater4_type'] = heater4Type;
    data['heater4_warranty'] = heater4Warranty;
    data['heater4_initiated_date'] = heater4InitiatedDate;
    data['heater4_end_date'] = heater4EndDate;
    data['heater4_wiespl_initiated_date'] = heater4WiesplInitiatedDate;
    data['heater4_wiespl_end_date'] = heater4WiesplEndDate;
    data['acd_pipe_length'] = acdPipeLength;
    data['acd_odu_tonnage'] = acdOduTonnage;
    data['acd_odu_tonnage_make'] = acdOduTonnageMake;
    data['acd_odut_initiated_date'] = acdOdutInitiatedDate;
    data['acd_odut_end_date'] = acdOdutEndDate;
    data['acd_odut_wiespl_initiated_date'] = acdOdutWiesplInitiatedDate;
    data['acd_odut_wiespl_end_date'] = acdOdutWiesplEndDate;
    data['acd_odu_compressor'] = acdOduCompressor;
    data['acd_odu_compressor_type'] = acdOduCompressorType;
    data['acd_odu_compressor_make'] = acdOduCompressorMake;
    data['acd_oduc_initiated_date'] = acdOducInitiatedDate;
    data['acd_oduc_end_date'] = acdOducEndDate;
    data['acd_oduc_wiespl_initiated_date'] = acdOducWiesplInitiatedDate;
    data['acd_oduc_wiespl_end_date'] = acdOducWiesplEndDate;
    data['acd_odu_condenser_fan_motor'] = acdOduCondenserFanMotor;
    data['acd_oducfm_initiated_date'] = acdOducfmInitiatedDate;
    data['acd_oducfm_end_date'] = acdOducfmEndDate;
    data['acd_oducfm_wiespl_initiated_date'] =
        acdOducfmWiesplInitiatedDate;
    data['acd_oducfm_wiespl_end_date'] = acdOducfmWiesplEndDate;
    data['acd_odu_condenser_fan_blade'] = acdOduCondenserFanBlade;
    data['acd_odu_condenser_fan_blade_warranty'] =
        acdOduCondenserFanBladeWarranty;
    data['acd_oducfb_initiated_date'] = acdOducfbInitiatedDate;
    data['acd_oducfb_end_date'] = acdOducfbEndDate;
    data['acd_oducfb_wiespl_initiated_date'] =
        acdOducfbWiesplInitiatedDate;
    data['acd_oducfb_wiespl_end_date'] = acdOducfbWiesplEndDate;
    data['acd_expension_device'] = acdExpensionDevice;
    data['acd_ed_initiated_date'] = acdEdInitiatedDate;
    data['acd_ed_end_date'] = acdEdEndDate;
    data['acd_ed_wiespl_initiated_date'] = acdEdWiesplInitiatedDate;
    data['acd_ed_wiespl_end_date'] = acdEdWiesplEndDate;
    data['acd_dryer_filter'] = acdDryerFilter;
    data['acd_df_initiated_date'] = acdDfInitiatedDate;
    data['acd_df_end_date'] = acdDfEndDate;
    data['acd_df_wiespl_initiated_date'] = acdDfWiesplInitiatedDate;
    data['acd_df_wiespl_end_date'] = acdDfWiesplEndDate;
    data['acd_lp_switch'] = acdLpSwitch;
    data['acd_lps_initiated_date'] = acdLpsInitiatedDate;
    data['acd_lps_end_date'] = acdLpsEndDate;
    data['acd_lps_wiespl_initiated_date'] = acdLpsWiesplInitiatedDate;
    data['acd_lps_wiespl_end_date'] = acdLpsWiesplEndDate;
    data['acd_hp_switch'] = acdHpSwitch;
    data['acd_hps_initiated_date'] = acdHpsInitiatedDate;
    data['acd_hps_end_date'] = acdHpsEndDate;
    data['acd_hps_wiespl_initiated_date'] = acdHpsWiesplInitiatedDate;
    data['acd_hps_wiespl_end_date'] = acdHpsWiesplEndDate;
    data['acd_odu_gas'] = acdOduGas;
    data['acd_odu_gas_quantity'] = acdOduGasQuantity;
    data['odu_tonnage'] = oduTonnage;
    data['odu_tonnage_make'] = oduTonnageMake;
    data['odut_initiated_date'] = odutInitiatedDate;
    data['odut_end_date'] = odutEndDate;
    data['odut_wiespl_initiated_date'] = odutWiesplInitiatedDate;
    data['odut_wiespl_end_date'] = odutWiesplEndDate;
    data['odu_compressor'] = oduCompressor;
    data['odu_compressor_type'] = oduCompressorType;
    data['odu_compressor_make'] = oduCompressorMake;
    data['oduc_initiated_date'] = oducInitiatedDate;
    data['oduc_end_date'] = oducEndDate;
    data['oduc_wiespl_initiated_date'] = oducWiesplInitiatedDate;
    data['oduc_wiespl_end_date'] = oducWiesplEndDate;
    data['odu_condenser_fan_motor'] = oduCondenserFanMotor;
    data['oducfm_initiated_date'] = oducfmInitiatedDate;
    data['oducfm_end_date'] = oducfmEndDate;
    data['oducfm_wiespl_initiated_date'] = oducfmWiesplInitiatedDate;
    data['oducfm_wiespl_end_date'] = oducfmWiesplEndDate;
    data['odu_condenser_fan_blade'] = oduCondenserFanBlade;
    data['oducfb_initiated_date'] = oducfbInitiatedDate;
    data['oducfb_end_date'] = oducfbEndDate;
    data['oducfb_wiespl_initiated_date'] = oducfbWiesplInitiatedDate;
    data['oducfb_wiespl_end_date'] = oducfbWiesplEndDate;
    data['expension_device'] = expensionDevice;
    data['ed_initiated_date'] = edInitiatedDate;
    data['ed_end_date'] = edEndDate;
    data['ed_wiespl_initiated_date'] = edWiesplInitiatedDate;
    data['ed_wiespl_end_date'] = edWiesplEndDate;
    data['dryer_filter'] = dryerFilter;
    data['df_initiated_date'] = dfInitiatedDate;
    data['df_end_date'] = dfEndDate;
    data['df_wiespl_initiated_date'] = dfWiesplInitiatedDate;
    data['df_wiespl_end_date'] = dfWiesplEndDate;
    data['lp_switch'] = lpSwitch;
    data['lps_initiated_date'] = lpsInitiatedDate;
    data['lps_end_date'] = lpsEndDate;
    data['lps_wiespl_initiated_date'] = lpsWiesplInitiatedDate;
    data['lps_wiespl_end_date'] = lpsWiesplEndDate;
    data['hp_switch'] = hpSwitch;
    data['hps_initiated_date'] = hpsInitiatedDate;
    data['hps_end_date'] = hpsEndDate;
    data['hps_wiespl_initiated_date'] = hpsWiesplInitiatedDate;
    data['hps_wiespl_end_date'] = hpsWiesplEndDate;
    data['odu_gas'] = oduGas;
    data['odu_gas_quantity'] = oduGasQuantity;
    data['fire_damper'] = fireDamper;
    data['fire_damper_accuator'] = fireDamperAccuator;
    data['thermal_expansion_device'] = thermalExpansionDevice;
    data['expansion_valve_orifice'] = expansionValveOrifice;
    data['thyristor'] = thyristor;
    data['thyristor_initiated_date'] = thyristorInitiatedDate;
    data['thyristor_end_date'] = thyristorEndDate;
    data['thyristor_wiespl_initiated_date'] .thyristorWiesplInitiatedDate;
    data['thyristor_wiespl_end_date'] = thyristorWiesplEndDate;
    data['plc'] = plc;
    data['plc_initiated_date'] = plcInitiatedDate;
    data['plc_end_date'] = plcEndDate;
    data['plc_wiespl_initiated_date'] = plcWiesplInitiatedDate;
    data['plc_wiespl_end_date'] = plcWiesplEndDate;
    data['fine_filter'] = fineFilter;
    data['fine_filter_length'] = fineFilterLength;
    data['fine_filter_width'] = fineFilterWidth;
    data['fine_filter_quantity'] = fineFilterQuantity;
    data['ff_initiated_date'] = ffInitiatedDate;
    data['ff_end_date'] = ffEndDate;
    data['ff_wiespl_initiated_date'] = ffWiesplInitiatedDate;
    data['ff_wiespl_end_date'] = ffWiesplEndDate;
    data['pre_filter_length'] = preFilterLength;
    data['pre_filter_width'] = preFilterWidth;
    data['pre_filter_quantity'] = preFilterQuantity;
    data['pf_initiated_date'] = pfInitiatedDate;
    data['pf_end_date'] = pfEndDate;
    data['pf_wiespl_initiated_date'] = pfWiesplInitiatedDate;
    data['pf_wiespl_end_date'] = pfWiesplEndDate;
    data['epic_filter_length'] = epicFilterLength;
    data['epic_filter_width'] = epicFilterWidth;
    data['epic_filter_quantity'] = epicFilterQuantity;
    data['ef_initiated_date'] = efInitiatedDate;
    data['ef_end_date'] = efEndDate;
    data['ef_wiespl_initiated_date'] = efWiesplInitiatedDate;
    data['ef_wiespl_end_date'] = efWiesplEndDate;
    data['hepa1_length'] = hepa1Length;
    data['hepa1_width'] = hepa1Width;
    data['hepa1_quantity'] = hepa1Quantity;
    data['hepa1_initiated_date'] = hepa1InitiatedDate;
    data['hepa1_end_date'] = hepa1EndDate;
    data['hepa1_wiespl_initiated_date'] = hepa1WiesplInitiatedDate;
    data['hepa1_wiespl_end_date'] = hepa1WiesplEndDate;
    data['hepa1_make'] = hepa1Make;
    data['hepa2_length'] = hepa2Length;
    data['hepa2_width'] = hepa2Width;
    data['hepa2_quantity'] = hepa2Quantity;
    data['hepa2_initiated_date'] = hepa2InitiatedDate;
    data['hepa2_end_date'] = hepa2EndDate;
    data['hepa2_wiespl_initiated_date'] = hepa2WiesplInitiatedDate;
    data['hepa2_wiespl_end_date'] = hepa2WiesplEndDate;
    data['hepa2_make'] = hepa2Make;
    data['uv1_length'] = uv1Length;
    data['uv1_width'] = uv1Width;
    data['uv1_quantity'] = uv1Quantity;
    data['uv1_initiated_date'] = uv1InitiatedDate;
    data['uv1_end_date'] = uv1EndDate;
    data['uv1_wiespl_initiated_date'] = uv1WiesplInitiatedDate;
    data['uv1_wiespl_end_date'] = uv1WiesplEndDate;
    data['uv2_length'] = uv2Length;
    data['uv2_width'] = uv2Width;
    data['uv2_quantity'] = uv2Quantity;
    data['uv2_initiated_date'] = uv2InitiatedDate;
    data['uv2_end_date'] = uv2EndDate;
    data['uv2_wiespl_initiated_date'] = uv2WiesplInitiatedDate;
    data['uv2_wiespl_end_date'] = uv2WiesplEndDate;
    data['uv3_length'] = uv3Length;
    data['uv3_width'] = uv3Width;
    data['uv3_quantity'] = uv3Quantity;
    data['uv3_initiated_date'] = uv3InitiatedDate;
    data['uv3_end_date'] = uv3EndDate;
    data['uv3_wiespl_initiated_date'] = uv3WiesplInitiatedDate;
    data['uv3_wiespl_end_date'] = uv3WiesplEndDate;
    data['uv4_length'] = uv4Length;
    data['uv4_width'] = uv4Width;
    data['uv4_quantity'] = uv4Quantity;
    data['uv4_initiated_date'] = uv4InitiatedDate;
    data['uv4_end_date'] = uv4EndDate;
    data['uv4_wiespl_initiated_date'] = uv4WiesplInitiatedDate;
    data['uv4_wiespl_end_date'] = uv4WiesplEndDate;
    data['humidity_and_temp_controller'] = humidityAndTempController;
    data['cp_initiated_date'] = cpInitiatedDate;
    data['cp_end_date'] = cpEndDate;
    data['cp_wiespl_initiated_date'] = cpWiesplInitiatedDate;
    data['cp_wiespl_end_date'] = cpWiesplEndDate;
    data['day_time_clock'] = dayTimeClock;
    data['dtc_initiated_date'] = dtcInitiatedDate;
    data['dtc_end_date'] = dtcEndDate;
    data['dtc_wiespl_initiated_date'] = dtcWiesplInitiatedDate;
    data['dtc_wiespl_end_date'] = dtcWiesplEndDate;
    data['time_elapsed_clock'] = timeElapsedClock;
    data['tec_initiated_date'] = tecInitiatedDate;
    data['tec_end_date'] = tecEndDate;
    data['tec_wiespl_initiated_date'] = tecWiesplInitiatedDate;
    data['tec_wiespl_end_date'] = tecWiesplEndDate;
    data['smps'] = smps;
    data['smps_initiated_date'] = smpsInitiatedDate;
    data['smps_end_date'] = smpsEndDate;
    data['smps_wiespl_initiated_date'] = smpsWiesplInitiatedDate;
    data['smps_wiespl_end_date'] = smpsWiesplEndDate;
    data['timer_cell'] = timerCell;
    data['tc_initiated_date'] = tcInitiatedDate;
    data['tc_end_date'] = tcEndDate;
    data['tc_wiespl_initiated_date'] = tcWiesplInitiatedDate;
    data['tc_wiespl_end_date'] = tcWiesplEndDate;
    data['control_panel_dwg'] = controlPanelDwg;
    data['ceilling_panel'] = ceillingPanel;
    data['wall_panel'] = wallPanel;
    data['wall_panel_description'] = wallPanelDescription;
    data['glass_panel'] = glassPanel;
    data['ot_image'] = otImage;
    data['door_type1'] = doorType1;
    data['dt1_initiated_date'] = dt1InitiatedDate;
    data['dt1_end_date'] = dt1EndDate;
    data['dt1_wiespl_initiated_date'] = dt1WiesplInitiatedDate;
    data['dt1_wiespl_end_date'] = dt1WiesplEndDate;
    data['door_type2'] = doorType2;
    data['warranty'] = warranty;
    data['dt2_initiated_date'] = dt2InitiatedDate;
    data['dt2_end_date'] = dt2EndDate;
    data['dt2_wiespl_initiated_date'] = dt2WiesplInitiatedDate;
    data['dt2_wiespl_end_date'] = dt2WiesplEndDate;
    data['door_material'] = doorMaterial;
    data['tower_bolt_make'] = towerBoltMake;
    data['door_close_specs'] = doorCloseSpecs;
    data['door_close_make'] = doorCloseMake;
    data['air_shower'] = airShower;
    data['air_shower_size'] = airShowerSize;
    data['vinyl_flooring_ot'] = vinylFlooringOt;
    data['pass_box'] = passBox;
    data['pass_box2'] = passBox2;
    data['automatic_surgical_scrub'] = automaticSurgicalScrub;
    data['ass_initiated_date'] = assInitiatedDate;
    data['ass_end_date'] = assEndDate;
    data['ass_wiespl_initiated_date'] = assWiesplInitiatedDate;
    data['ass_wiespl_end_date'] = assWiesplEndDate;
    data['manual_surgical_scrub'] = manualSurgicalScrub;
    data['no_of_bay'] = noOfBay;
    data['mode_of_operation'] = modeOfOperation;
    data['pendant'] = pendant;
    data['pendant_type'] = pendantType;
    data['steel_certification'] = steelCertification;
    data['ahu_doc'] = ahuDoc;
    data['duct_material'] = ductMaterial;
    data['duct_insulation'] = ductInsulation;
    data['glass'] = glass;
    data['temperature_sensor'] = temperatureSensor;
    data['humidity_sensor'] = humiditySensor;
    data['motor_doc'] = motorDoc;
    data['blower_doc'] = blowerDoc;
    data['vfd'] = vfd;
    data['coil'] = coil;
    data['damper'] = damper;
    data['heater'] = heater;
    data['user_manual'] = userManual;
    data['hepa_filter'] = hepaFilter;
    data['fine_filter_doc'] = fineFilterDoc;
    data['pre_filter'] = preFilter;
    data['pressure_guage_meter'] = pressureGuageMeter;
    data['copper_pipe'] = copperPipe;
    data['ot_drawing'] = otDrawing;
    data['ahu_drawing'] = ahuDrawing;
    data['flooring_drawing'] = flooringDrawing;
    data['coil_specification'] = coilSpecification;
    data['ducting_drawing'] = ductingDrawing;
    data['air_validation_report'] = airValidationReport;
    data['piping_drawing'] = pipingDrawing;
    data['control_panel_wiring_drawing'] = controlPanelWiringDrawing;
    data['plenum_drawing'] = plenumDrawing;
    data['odu_tds'] = oduTds;
    data['site_id'] = siteId;
    data['created_by'] = createdBy;
    data['status'] = status;
    data['mpin'] = mpin;
    data['mpin_change_request'] = mpinChangeRequest;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['request_type'] = requestType;
    data['system_status'] = systemStatus;
    data['active_temperature'] = activeTemperature;
    data['relative_hummidity'] = relativeHummidity;
    data['set_humidity'] = setHumidity;
    data['set_temperature'] = setTemperature;
    data['request_status'] = requestStatus;
    return data;
  }
}