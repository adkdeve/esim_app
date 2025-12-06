class EsimProduct {
  final String uid;
  final String name;
  final List<String> countriesEnabled;
  final int dataQuotaMb;
  final int validityDays;
  final double retailPrice;

  EsimProduct({
    required this.uid,
    required this.name,
    required this.countriesEnabled,
    required this.dataQuotaMb,
    required this.validityDays,
    required this.retailPrice,
  });

  factory EsimProduct.fromJson(Map<String, dynamic> json) {
    return EsimProduct(
      uid: json['uid']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Unknown Plan',
      countriesEnabled: json['countries_enabled'] != null
          ? List<String>.from(json['countries_enabled'])
          : [],
      dataQuotaMb: int.tryParse(json['data_quota_mb']?.toString() ?? '0') ?? 0,
      validityDays: int.tryParse(json['validity_days']?.toString() ?? '0') ?? 0,
      retailPrice: double.tryParse(json['rrp_usd']?.toString() ?? '0') ?? 0.0,
    );
  }

  String get countryFromProductName {
    final parts = name.split(RegExp(r'\s\d'));
    if (parts.isNotEmpty) {
      return parts.first.trim();
    }
    return name;
  }
}