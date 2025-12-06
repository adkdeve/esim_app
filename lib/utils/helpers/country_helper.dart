class CountryHelper {
  // CHANGED parameter name from 'iso3' to 'iso3Code' to match the logic below
  static String getIso2FromIso3(String iso3Code) {
    const map = {
      'AFG': 'af', 'ALB': 'al', 'DZA': 'dz', 'AND': 'ad', 'AGO': 'ao',
      'ARG': 'ar', 'ARM': 'am', 'ABW': 'aw', 'AUS': 'au', 'AUT': 'at',
      'AZE': 'az', 'BHS': 'bs', 'BHR': 'bh', 'BGD': 'bd', 'BRB': 'bb',
      'BLR': 'by', 'BEL': 'be', 'BLZ': 'bz', 'BEN': 'bj', 'BMU': 'bm',
      'BTN': 'bt', 'BOL': 'bo', 'BIH': 'ba', 'BWA': 'bw', 'BRA': 'br',
      'BRN': 'bn', 'BGR': 'bg', 'BFA': 'bf', 'BDI': 'bi', 'KHM': 'kh',
      'CMR': 'cm', 'CAN': 'ca', 'CPV': 'cv', 'CYM': 'ky', 'CAF': 'cf',
      'TCD': 'td', 'CHL': 'cl', 'CHN': 'cn', 'COL': 'co', 'COM': 'km',
      'COG': 'cg', 'COD': 'cd', 'CRI': 'cr', 'CIV': 'ci', 'HRV': 'hr',
      'CUB': 'cu', 'CYP': 'cy', 'CZE': 'cz', 'DNK': 'dk', 'DJI': 'dj',
      'DMA': 'dm', 'DOM': 'do', 'ECU': 'ec', 'EGY': 'eg', 'SLV': 'sv',
      'EST': 'ee', 'ETH': 'et', 'FJI': 'fj', 'FIN': 'fi', 'FRA': 'fr',
      'GAB': 'ga', 'GMB': 'gm', 'GEO': 'ge', 'DEU': 'de', 'GHA': 'gh',
      'GRC': 'gr', 'GRD': 'gd', 'GTM': 'gt', 'GIN': 'gn', 'GUY': 'gy',
      'HTI': 'ht', 'HND': 'hn', 'HKG': 'hk', 'HUN': 'hu', 'ISL': 'is',
      'IND': 'in', 'IDN': 'id', 'IRN': 'ir', 'IRQ': 'iq', 'IRL': 'ie',
      'ISR': 'il', 'ITA': 'it', 'JAM': 'jm', 'JPN': 'jp', 'JOR': 'jo',
      'KAZ': 'kz', 'KEN': 'ke', 'KIR': 'ki', 'KWT': 'kw', 'KGZ': 'kg',
      'LAO': 'la', 'LVA': 'lv', 'LBN': 'lb', 'LSO': 'ls', 'LBR': 'lr',
      'LBY': 'ly', 'LIE': 'li', 'LTU': 'lt', 'LUX': 'lu', 'MAC': 'mo',
      'MKD': 'mk', 'MDG': 'mg', 'MWI': 'mw', 'MYS': 'my', 'MDV': 'mv',
      'MLI': 'ml', 'MLT': 'mt', 'MRT': 'mr', 'MUS': 'mu', 'MEX': 'mx',
      'MDA': 'md', 'MCO': 'mc', 'MNG': 'mn', 'MNE': 'me', 'MAR': 'ma',
      'MOZ': 'mz', 'MMR': 'mm', 'NAM': 'na', 'NPL': 'np', 'NLD': 'nl',
      'NZL': 'nz', 'NIC': 'ni', 'NER': 'ne', 'NGA': 'ng', 'NOR': 'no',
      'OMN': 'om', 'PAK': 'pk', 'PAN': 'pa', 'PNG': 'pg', 'PRY': 'py',
      'PER': 'pe', 'PHL': 'ph', 'POL': 'pl', 'PRT': 'pt', 'QAT': 'qa',
      'ROU': 'ro', 'RUS': 'ru', 'RWA': 'rw', 'SAU': 'sa', 'SEN': 'sn',
      'SRB': 'rs', 'SYC': 'sc', 'SLE': 'sl', 'SGP': 'sg', 'SVK': 'sk',
      'SVN': 'si', 'ZAF': 'za', 'KOR': 'kr', 'ESP': 'es', 'LKA': 'lk',
      'SDN': 'sd', 'SUR': 'sr', 'SWE': 'se', 'CHE': 'ch', 'SYR': 'sy',
      'TWN': 'tw', 'TJK': 'tj', 'TZA': 'tz', 'THA': 'th', 'TGO': 'tg',
      'TON': 'to', 'TTO': 'tt', 'TUN': 'tn', 'TUR': 'tr', 'TKM': 'tm',
      'UGA': 'ug', 'UKR': 'ua', 'ARE': 'ae', 'GBR': 'gb', 'USA': 'us',
      'URY': 'uy', 'UZB': 'uz', 'VEN': 've', 'VNM': 'vn', 'YEM': 'ye',
      'ZMB': 'zm', 'ZWE': 'zw'
    };

    // Now 'iso3Code' is defined correctly
    return map[iso3Code.toUpperCase()] ?? iso3Code.substring(0, 2).toLowerCase();
  }
}