class AdsData {
  final String isAdmob;
  final String idBanner;
  final String idInter;
  final String idNative;
  final String appkey;

  AdsData({
    required this.isAdmob,
    required this.idBanner,
    required this.idInter,
    required this.idNative,
    required this.appkey,
  });

  AdsData.fromJson(Map<String, dynamic> json)
      : isAdmob = json['isAdmob'] ?? "",
        idBanner = json['idBanner'] ?? "",
        idInter = json['idInter'] ?? "",
        idNative = json['idNative'] ?? "",
        appkey = json['appkey'] ?? "";

  Map<String, String> toJson() => {
        'isAdmob': isAdmob,
        'idBanner': idBanner,
        'idInter': idInter,
        'idNative': idNative,
        'appkey': appkey,
      };
}
