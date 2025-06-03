class LiveParameterResponse {
  int? status;
  LiveParameterResult? result;

  LiveParameterResponse({this.status, this.result});

  LiveParameterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    result =
    json['result'] != null ? LiveParameterResult.fromJson(json['result']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (result != null) {
      data['result'] = result!.toJson();
    }
    return data;
  }
}

class LiveParameterResult {
  int? id;
  int? sRWSL;
  int? cFAN;
  int? cAC1;
  int? cAC2;
  int? cHTR1;
  int? cHTR2;
  int? cHTR3;
  int? cHTR4;
  int? cRVOLT;
  int? cYVOLT;
  int? cBVOLT;
  int? cOTTEMP;
  int? cRH;
  int? cRFANAMP;
  int? cHTRAMP;
  int? cAC1AMP;
  int? cAC2AMP;
  int? cDMPROPEN;
  int? cBLOWERHz;
  int? cCIOLTEMPSIGN;
  int? cCIOLTEMP;
  int? cFAULTYHTR;
  int? cBALANCECYCLETIMEHTR;

  int? fUV;
  int? fOV;
  int? fFANOL;
  int? fFANUL;
  int? fFIRE;
  int? fTEMPSSR;
  int? fTEMPHIGH;
  int? fTEMPLOW;
  int? fRHHIGH;
  int? fRHSSRFAIL;
  int? fAC1OL;
  int? fAC1UL;
  int? fAC1LP;
  int? fAC1HP;
  int? fAC2OL;
  int? fAC2UL;
  int? fAC2LP;
  int? fAC2HP;

  int? sUNDERVOLT;
  int? sOVERVOLT;
  int? sTEMPSETPT;
  int? sRHSETPT;
  int? sINCREMENTAL;
  int? sDMPRMODE;
  int? sDMPRVALUE;
  int? sRHDIFFPLUS;
  int? sRHDIFFMINUS;
  int? sHTRONTEMP;
  int? sHTROFFTEMP;
  int? sMAXDAM;
  int? sMINDAM;
  int? sVFDHz;
  int? sNMVFDHz;
  int? sIDFANOL;
  int? sIDFANUL;
  int? sACOL;
  int? sACUL;
  int? sIDFANONDLY;
  int? sAC1ONDLY;
  int? sAC2ONDLY;
  int? sCYCLETIME;
  int? sAC1AUTOMAN;
  int? sAC2AUTOMAN;
  int? sHTR1AUTOMAN;
  int? sHTR2AUTOMAN;
  int? sHTR3AUTOMAN;
  int? sHTR4AUTOMAN;
  int? sVOLTPROTECT;
  int? sCURRPROTECT;
  int? sHTRONTEMPSIGN;
  int? sHEATERCYCLETIME;
  int? sHEATERKW;
  int? sHEATERCURRHYST;
  int? sIOTTIMER;
  String? createdAt;
  String? updatedAt;

  LiveParameterResult(
      {this.id,
        this.sRWSL,
        this.cFAN,
        this.cAC1,
        this.cAC2,
        this.cHTR1,
        this.cHTR2,
        this.cHTR3,
        this.cHTR4,
        this.cRVOLT,
        this.cYVOLT,
        this.cBVOLT,
        this.cOTTEMP,
        this.cRH,
        this.cRFANAMP,
        this.cHTRAMP,
        this.cAC1AMP,
        this.cAC2AMP,
        this.cDMPROPEN,
        this.cBLOWERHz,
        this.cCIOLTEMPSIGN,
        this.cCIOLTEMP,
        this.cFAULTYHTR,
        this.cBALANCECYCLETIMEHTR,
        this.fUV,
        this.fOV,
        this.fFANOL,
        this.fFANUL,
        this.fFIRE,
        this.fTEMPSSR,
        this.fTEMPHIGH,
        this.fTEMPLOW,
        this.fRHHIGH,
        this.fRHSSRFAIL,
        this.fAC1OL,
        this.fAC1UL,
        this.fAC1LP,
        this.fAC1HP,
        this.fAC2OL,
        this.fAC2UL,
        this.fAC2LP,
        this.fAC2HP,
        this.sUNDERVOLT,
        this.sOVERVOLT,
        this.sTEMPSETPT,
        this.sRHSETPT,
        this.sINCREMENTAL,
        this.sDMPRMODE,
        this.sDMPRVALUE,
        this.sRHDIFFPLUS,
        this.sRHDIFFMINUS,
        this.sHTRONTEMP,
        this.sHTROFFTEMP,
        this.sMAXDAM,
        this.sMINDAM,
        this.sVFDHz,
        this.sNMVFDHz,
        this.sIDFANOL,
        this.sIDFANUL,
        this.sACOL,
        this.sACUL,
        this.sIDFANONDLY,
        this.sAC1ONDLY,
        this.sAC2ONDLY,
        this.sCYCLETIME,
        this.sAC1AUTOMAN,
        this.sAC2AUTOMAN,
        this.sHTR1AUTOMAN,
        this.sHTR2AUTOMAN,
        this.sHTR3AUTOMAN,
        this.sHTR4AUTOMAN,
        this.sVOLTPROTECT,
        this.sCURRPROTECT,
        this.sHTRONTEMPSIGN,
        this.sHEATERCYCLETIME,
        this.sHEATERKW,
        this.sHEATERCURRHYST,
        this.sIOTTIMER,
        this.createdAt,
        this.updatedAt});

  LiveParameterResult.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sRWSL = json['SR_WSL'];
    cFAN = json['C_FAN']??0;
    cAC1 = json['C_AC1']??0;
    cAC2 = json['C_AC2']??0;
    cHTR1 = json['C_HTR1']??0;
    cHTR2 = json['C_HTR2']??0;
    cHTR3 = json['C_HTR3']??0;
    cHTR4 = json['C_HTR4']??0;
    cRVOLT = json['C_R_VOLT']??0;
    cYVOLT = json['C_Y_VOLT']??0;
    cBVOLT = json['C_B_VOLT']??0;
    cOTTEMP = json['C_OT_TEMP']??0;
    cRH = json['C_RH']??0;
    cRFANAMP = json['C_R_FAN_AMP']??0;
    cHTRAMP = json['C_HTR_AMP']??0;
    cAC1AMP = json['C_AC1_AMP']??0;
    cAC2AMP = json['C_AC2_AMP']??0;
    cDMPROPEN = json['C_DMPR_OPEN']??0;
    cBLOWERHz = json['C_BLOWER_Hz']??0;
    cCIOLTEMPSIGN = json['C_CIOL_TEMP_SIGN']??0;
    cCIOLTEMP = json['C_CIOL_TEMP']??0;
    cFAULTYHTR = json['C_FAULTY_HTR']??0;
    cBALANCECYCLETIMEHTR = json['C_BALANCE_CYCLE_TIME_HTR']??0;
    fUV = json['F_UV']??0;
    fOV = json['F_OV']??0;
    fFANOL = json['F_FAN_OL']??0;
    fFANUL = json['F_FAN_UL']??0;
    fFIRE = json['F_FIRE']??0;
    fTEMPSSR = json['F_TEMP_SSR']??0;
    fTEMPHIGH = json['F_TEMP_HIGH']??0;
    fTEMPLOW = json['F_TEMP_LOW']??0;
    fRHHIGH = json['F_RH_HIGH']??0;
    fRHSSRFAIL = json['F_RH_SSR_FAIL']??0;
    fAC1OL = json['F_AC1_OL']??0;
    fAC1UL = json['F_AC1_UL']??0;
    fAC1LP = json['F_AC1_LP']??0;
    fAC1HP = json['F_AC1_HP']??0;
    fAC2OL = json['F_AC2_OL']??0;
    fAC2UL = json['F_AC2_UL']??0;
    fAC2LP = json['F_AC2_LP']??0;
    fAC2HP = json['F_AC2_HP']??0;
    sUNDERVOLT = json['S_UNDER_VOLT']??0;
    sOVERVOLT = json['S_OVER_VOLT']??0;
    sTEMPSETPT = json['S_TEMP_SETPT']??0;
    sRHSETPT = json['S_RH_SETPT']??0;
    sINCREMENTAL = json['S_INCREMENTAL']??0;
    sDMPRMODE = json['S_DMPR_MODE']??0;
    sDMPRVALUE = json['S_DMPR_VALUE']??0;
    sRHDIFFPLUS = json['S_RH_DIFF_PLUS']??0;
    sRHDIFFMINUS = json['S_RH_DIFF_MINUS']??0;
    sHTRONTEMP = json['S_HTR_ON_TEMP']??0;
    sHTROFFTEMP = json['S_HTR_OFF_TEMP']??0;
    sMAXDAM = json['S_MAX_DAM']??0;
    sMINDAM = json['S_MIN_DAM']??0;
    sVFDHz = json['S_VFD_Hz']??0;
    sNMVFDHz = json['S_NM_VFD_Hz']??0;
    sIDFANOL = json['S_ID_FAN_OL']??0;
    sIDFANUL = json['S_ID_FAN_UL']??0;
    sACOL = json['S_AC_OL']??0;
    sACUL = json['S_AC_UL']??0;
    sIDFANONDLY = json['S_ID_FAN_ON_DLY']??0;
    sAC1ONDLY = json['S_AC1_ON_DLY']??0;
    sAC2ONDLY = json['S_AC2_ON_DLY']??0;
    sCYCLETIME = json['S_CYCLE_TIME']??0;
    sAC1AUTOMAN = json['S_AC1_AUTOMAN']??0;
    sAC2AUTOMAN = json['S_AC2_AUTOMAN']??0;
    sHTR1AUTOMAN = json['S_HTR1_AUTOMAN']??0;
    sHTR2AUTOMAN = json['S_HTR2_AUTOMAN']??0;
    sHTR3AUTOMAN = json['S_HTR3_AUTOMAN']??0;
    sHTR4AUTOMAN = json['S_HTR4_AUTOMAN']??0;
    sVOLTPROTECT = json['S_VOLTPROTECT']??0;
    sCURRPROTECT = json['S_CURRPROTECT']??0;
    sHTRONTEMPSIGN = json['S_HTR_ONTEMP_SIGN']??0;
    sHEATERCYCLETIME = json['S_HEATER_CYCLE_TIME']??0;
    sHEATERKW = json['S_HEATER_KW']??0;
    sHEATERCURRHYST = json['S_HEATER_CURR_HYST']??0;
    sIOTTIMER = json['S_IOT_TIMER']??0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['SR_WSL'] = sRWSL;
    data['C_FAN'] = cFAN;
    data['C_AC1'] = cAC1;
    data['C_AC2'] = cAC2;
    data['C_HTR1'] = cHTR1;
    data['C_HTR2'] = cHTR2;
    data['C_HTR3'] = cHTR3;
    data['C_HTR4'] = cHTR4;
    data['C_R_VOLT'] = cRVOLT;
    data['C_Y_VOLT'] = cYVOLT;
    data['C_B_VOLT'] = cBVOLT;
    data['C_OT_TEMP'] = cOTTEMP;
    data['C_RH'] = cRH;
    data['C_R_FAN_AMP'] = cRFANAMP;
    data['C_HTR_AMP'] = cHTRAMP;
    data['C_AC1_AMP'] = cAC1AMP;
    data['C_AC2_AMP'] = cAC2AMP;
    data['C_DMPR_OPEN'] = cDMPROPEN;
    data['C_BLOWER_Hz'] = cBLOWERHz;
    data['C_CIOL_TEMP_SIGN'] = cCIOLTEMPSIGN;
    data['C_CIOL_TEMP'] = cCIOLTEMP;
    data['C_FAULTY_HTR'] = cFAULTYHTR;
    data['C_BALANCE_CYCLE_TIME_HTR'] = cBALANCECYCLETIMEHTR;
    data['F_UV'] = fUV;
    data['F_OV'] = fOV;
    data['F_FAN_OL'] = fFANOL;
    data['F_FAN_UL'] = fFANUL;
    data['F_FIRE'] = fFIRE;
    data['F_TEMP_SSR'] = fTEMPSSR;
    data['F_TEMP_HIGH'] = fTEMPHIGH;
    data['F_TEMP_LOW'] = fTEMPLOW;
    data['F_RH_HIGH'] = fRHHIGH;
    data['F_RH_SSR_FAIL'] = fRHSSRFAIL;
    data['F_AC1_OL'] = fAC1OL;
    data['F_AC1_UL'] = fAC1UL;
    data['F_AC1_LP'] = fAC1LP;
    data['F_AC1_HP'] = fAC1HP;
    data['F_AC2_OL'] = fAC2OL;
    data['F_AC2_UL'] = fAC2UL;
    data['F_AC2_LP'] = fAC2LP;
    data['F_AC2_HP'] = fAC2HP;
    data['S_UNDER_VOLT'] = sUNDERVOLT;
    data['S_OVER_VOLT'] = sOVERVOLT;
    data['S_TEMP_SETPT'] = sTEMPSETPT;
    data['S_RH_SETPT'] = sRHSETPT;
    data['S_INCREMENTAL'] = sINCREMENTAL;
    data['S_DMPR_MODE'] = sDMPRMODE;
    data['S_DMPR_VALUE'] = sDMPRVALUE;
    data['S_RH_DIFF_PLUS'] = sRHDIFFPLUS;
    data['S_RH_DIFF_MINUS'] = sRHDIFFMINUS;
    data['S_HTR_ON_TEMP'] = sHTRONTEMP;
    data['S_HTR_OFF_TEMP'] = sHTROFFTEMP;
    data['S_MAX_DAM'] = sMAXDAM;
    data['S_MIN_DAM'] = sMINDAM;
    data['S_VFD_Hz'] = sVFDHz;
    data['S_NM_VFD_Hz'] = sNMVFDHz;
    data['S_ID_FAN_OL'] = sIDFANOL;
    data['S_ID_FAN_UL'] = sIDFANUL;
    data['S_AC_OL'] = sACOL;
    data['S_AC_UL'] = sACUL;
    data['S_ID_FAN_ON_DLY'] = sIDFANONDLY;
    data['S_AC1_ON_DLY'] = sAC1ONDLY;
    data['S_AC2_ON_DLY'] = sAC2ONDLY;
    data['S_CYCLE_TIME'] = sCYCLETIME;
    data['S_AC1_AUTOMAN'] = sAC1AUTOMAN;
    data['S_AC2_AUTOMAN'] = sAC2AUTOMAN;
    data['S_HTR1_AUTOMAN'] = sHTR1AUTOMAN;
    data['S_HTR2_AUTOMAN'] = sHTR2AUTOMAN;
    data['S_HTR3_AUTOMAN'] = sHTR3AUTOMAN;
    data['S_HTR4_AUTOMAN'] = sHTR4AUTOMAN;
    data['S_VOLTPROTECT'] = sVOLTPROTECT;
    data['S_CURRPROTECT'] = sCURRPROTECT;
    data['S_HTR_ONTEMP_SIGN'] = sHTRONTEMPSIGN;
    data['S_HEATER_CYCLE_TIME'] = sHEATERCYCLETIME;
    data['S_HEATER_KW'] = sHEATERKW;
    data['S_HEATER_CURR_HYST'] = sHEATERCURRHYST;
    data['S_IOT_TIMER'] = sIOTTIMER;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}