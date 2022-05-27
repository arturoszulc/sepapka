
const List<WireSymbol> wireSymbolsPolish = [
  WireSymbol('drut', 'D', 'DY'),
  WireSymbol('linka', 'L', 'LY'),
  WireSymbol('linka giętka', 'Lg', 'LgY'),
  WireSymbol('miedziany', '-', 'YKY'),
  WireSymbol('aluminiowy', 'A', 'YAKY'),
  WireSymbol('izolacja z polwinitu', 'Y', 'YKY'),
  WireSymbol('izolacja z polwinitowu samogasnącego', 'Yn', 'YnTKSXekw'),
  WireSymbol('izolacja z polwinitowu benzenopodobnego', 'Yb', 'YbKSY'),
  WireSymbol('izolacja z polietylenu niesieciowanego', 'X', 'XTKMXpw'),
  WireSymbol('izolacja z polietylenu sieciowanego', 'XS', 'YAKXS'),
  WireSymbol('izolacja z polietylenu z zaporą przeciwwilgociową', 'Xz', 'XzTKMXp'),
  WireSymbol('izolacja z polietylenu piankowego', 'Xp', 'XzTKMXp'),
  WireSymbol('izolacja gumowa (opona)', 'O', 'OWY'),
  WireSymbol('pancerz z taśmy stalowej', 'Ft', 'YKYFty'),
  WireSymbol('pancerz z taśmy stalowej lakierowanej', 'Ftl', 'YKYFtly'),
  WireSymbol('pancerz z taśmy z drutów stalowych okrągłych', 'Fo', 'YKYFoy'),
  WireSymbol('pancerz z taśmy z drutów stalowych płaskich', 'Fp', 'YKYFp'),
  WireSymbol('ekran wspólny', 'ekw', 'YbStYekw'),
  WireSymbol('pary indywidualnie ekranowane', 'ekp', 'YTKSYekp'),
  WireSymbol('ekran taśmowy', 'ekt', 'YstYekt'),
  WireSymbol('ekran z drutu', 'eko', 'YstYeko'),
  WireSymbol('wtynkowy', 't', 'YDYt'),
  WireSymbol('wzmocniona izolacja', 'd', 'OPd'),
  WireSymbol('ciepłoodporny', 'c', 'DYc'),
  WireSymbol('płaski', 'p', 'YDYp'),
  WireSymbol('samonośny', 's', 'AxXS'),
  WireSymbol('niepalny', 'n', 'AsXSn'),
  WireSymbol('z żyłą ochronną (żółto-zieloną)', 'żo', 'YKYżo'),
  WireSymbol('górniczy', 'G', 'YKGYtlyn'),
  WireSymbol('sterowniczy', 'ST', 'YSTYżo'),
  WireSymbol('sygnalizacyjny', 'S', 'YKSY9OS'),
  WireSymbol('spawalniczy', 'OS', 'OS'),
  WireSymbol('sznurowy mieszkaniowy', 'SM', 'SMYp'),
  WireSymbol('oponowy warsztatowy', 'OW', 'OWY'),
  WireSymbol('oponowy mieszkaniowy', 'OM', 'OMYm'),
  WireSymbol('oponowy przemysłowy', 'OP', 'OPd'),
  WireSymbol('radiofoniczny', 'RP', 'XRPX'),
  WireSymbol('do instalacji samochodowych', '-S', 'YLY-S'),
  WireSymbol('telekomunikacyjny stacyjny', 'TKS', 'TKS'),
  WireSymbol('telekomunikacyjny miejscowy', 'TKM', 'XzTKMXw'),
  WireSymbol('telekomunikacyjny instalacyjny', 'J-', 'J-Y'),
  WireSymbol('telekomunikacyjny słąboprądowy', 'T', 'TDY'),
  WireSymbol('do sygnałów alarmowych', 'TKS', 'YnTKSYekw'),
  WireSymbol('skrętka nieekranowana', 'UTP', 'UTP'),
  WireSymbol('skrętka ekranowana', 'FTP', 'FTP'),
  WireSymbol('skrętka ekranowana parami', 'STP', 'STP'),
  WireSymbol('skrętka ekranowana parami + ekran wspólny', 'S-STP', 'S-STP'),
  WireSymbol('rozetowy', 'OTKr', 'XOTKrd'),
  WireSymbol('tubowy', 'OTKt', 'YOTKrt'),

];

const Map<String, List<WireSymbolHarmonized>> wireSymbolsHarmonized = {
 '1. Rodzaj standardu': [
   WireSymbolHarmonized('zharmonizowany', 'H'),
   WireSymbolHarmonized('krajowy autoryzowany', 'A'),
   WireSymbolHarmonized('krajowy nieautoryzowany', 'N'),
 ],
  '2. Napięcie znamionowe': [
    WireSymbolHarmonized('100/100 V', '01'),
    WireSymbolHarmonized('300/300 V', '03'),
    WireSymbolHarmonized('300/500 V', '05'),
    WireSymbolHarmonized('450/750 V', '07'),
    WireSymbolHarmonized('600/1000 V', '11'),
  ],
  '3. Materiał izolacji': [
    WireSymbolHarmonized('guma etylenowo-propylenowa (EPR)', 'B'),
    WireSymbolHarmonized('polietylen o małej gęstości (LDPE)', 'E'),
    WireSymbolHarmonized('polietylen o dużej gęstości (HDPE)', 'E2'),
    WireSymbolHarmonized('etylen / octan winylu (EVA)', 'G'),
    WireSymbolHarmonized('guma chloroprenowa', 'N'),
    WireSymbolHarmonized('guma z kauczku naturalnego lub syntetycznego', 'R'),
    WireSymbolHarmonized('guma silikonowa', 'S'),
    WireSymbolHarmonized('polwinit (PVC)', 'V'),
    WireSymbolHarmonized('polwinit (PVC) ciepłoodporny', 'V2'),
    WireSymbolHarmonized('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbolHarmonized('polwinit (PVC) usieciowany', 'V4'),
    WireSymbolHarmonized('polietylen usieciowany (XLPE)', 'X'),
  ],
  '4. Materiał powłoki': [
    WireSymbolHarmonized('guma etylenowo-propylenowa (EPR)', 'B'),
    WireSymbolHarmonized('etylen / octan winylu (EVA)', 'G'),
    WireSymbolHarmonized('guma chloroprenowa', 'N'),
    WireSymbolHarmonized('guma z kauczku naturalnego lub syntetycznego', 'R'),
    WireSymbolHarmonized('guma silikonowa', 'S'),
    WireSymbolHarmonized('oplot z włókna szklanego (GFB)', 'J'),
    WireSymbolHarmonized('oplot bawełniany', 'T'),
    WireSymbolHarmonized('polwinit (PVC)', 'V'),
    WireSymbolHarmonized('polwinit (PVC) ciepłoodporny', 'V2'),
    WireSymbolHarmonized('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbolHarmonized('polwinit (PVC) usieciowany', 'V4'),
    WireSymbolHarmonized('polwinit (PVC) olejoodporny', 'V5'),
  ],
  '5. Kształ budowy zewnętrznej': [
    WireSymbolHarmonized('przewód płaski, podzielny', 'H'),
    WireSymbolHarmonized('przewód płaski, niepodzielny', 'H2'),
    WireSymbolHarmonized('dwa lub więcej rdzeni skręconych ze sobą', 'H5'),
    WireSymbolHarmonized('izolacja dwuwarstwowa', 'H7'),
    WireSymbolHarmonized('przewód spiralny', 'H8'),
  ],
  '6. Rodzaj przewodu': [
    WireSymbolHarmonized('jednodrutowy', 'U'),
    WireSymbolHarmonized('wielodrutowy, sztywny', 'R'),
    WireSymbolHarmonized('linka, do przewodów spawalniczych', 'D'),
    WireSymbolHarmonized('linka, do układania na stałe', 'K'),
    WireSymbolHarmonized('linka, do odbiorników ruchomych', 'F'),
    WireSymbolHarmonized('linka cienkodrutowa, bardzo giętka', 'H'),
    WireSymbolHarmonized('lica szychowa, bardzo giętka', 'Y'),
  ],
  '7. Liczba żył w przewodzie': [
    WireSymbolHarmonized('jedna', '1'),
    WireSymbolHarmonized('dwie', '2'),
    WireSymbolHarmonized('...', '...'),
  ],
  '8. Żyła ochronna': [
    WireSymbolHarmonized('brak żyły ochronnej', 'X'),
    WireSymbolHarmonized('z żyłą ochronną', 'G'),
  ],
  '9. Przekrój znamionowy żył': [
    WireSymbolHarmonized('przekrój każdej żyły: 0,5 mm\u2082', '0,5'),
    WireSymbolHarmonized('przekrój każdej żyły: 0,75 mm\u2082', '0,75'),
    WireSymbolHarmonized('przekrój każdej żyły: 1 mm\u2082', '1'),
    WireSymbolHarmonized('...', ''),
  ],
};


class WireSymbolHarmonized {
  final String description;
  final String symbol;

  const WireSymbolHarmonized(this.description, this.symbol);

  List<String> toRow() {
    return [description, symbol];
  }
}

class WireSymbol {
  final String construction;
  final String symbol;
  final String example;

  const WireSymbol(this.construction, this.symbol, this.example);


}