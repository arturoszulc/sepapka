
const Map<String, List<WireSymbol>> wireSymbolsPolish = {
  '1. Budowa żyły': [
    WireSymbol('drut', 'D'),
    WireSymbol('linka', 'L'),
    WireSymbol('linka giętka', 'Lg'),
  ],
  '2. Materiał żyły': [
    WireSymbol('miedź', 'brak'),
    WireSymbol('aluminium', 'A'),
  ],
  '3. Materiał izolacji lub powłoki': [
    WireSymbol('polwinit', 'Y'),
    WireSymbol('polwinit samogasnący', 'Yn'),
    WireSymbol('polwinit benzenopodobny', 'Yb'),
    WireSymbol('polietylen niesieciowany', 'X'),
    WireSymbol('polietylen sieciowany', 'XS'),
    WireSymbol('polietylen z zaporą przeciwwilgociową', 'Xz'),
    WireSymbol('polietylen piankowy', 'Xp'),
    WireSymbol('guma (opona)', 'O'),
  ],
  '4. Pancerz': [
    WireSymbol('taśma stalowa', 'Ft'),
    WireSymbol('taśma stalowa lakierowana', 'Ftl'),
    WireSymbol('taśma z drutów stalowych okrągłych', 'Fo'),
    WireSymbol('taśma z drutów stalowych płaskich', 'Fp'),
  ],
  '5. Ekran': [
    WireSymbol('wspólny', 'ekw'),
    WireSymbol('pary indywidualnie ekranowane', 'ekp'),
    WireSymbol('taśma', 'ekt'),
    WireSymbol('drut', 'eko'),
  ],
  '6. Oznaczenie dodatkowe': [
    WireSymbol('wtynkowy', 't'),
    WireSymbol('wzmocniona izolacja', 'd'),
    WireSymbol('ciepłoodporny', 'c'),
    WireSymbol('płaski', 'p'),
    WireSymbol('samonośny', 's'),
    WireSymbol('niepalny', 'n'),
    WireSymbol('z żyłą ochronną (żółto-zieloną)', 'żo'),
    WireSymbol('górniczy', 'G'),
    WireSymbol('sterowniczy', 'ST'),
    WireSymbol('sygnalizacyjny', 'S'),
    WireSymbol('spawalniczy', 'OS'),
  ],
  '7. Do odbiorników ruchomych i przenośnych': [
    WireSymbol('sznur mieszkaniowy', 'SM'),
    WireSymbol('przewód oponowy warsztatowy', 'OW'),
    WireSymbol('przewód oponowy mieszkaniowy', 'OM'),
    WireSymbol('przewód oponowy przemysłowy', 'OP'),
    WireSymbol('przewód radiofoniczny', 'RP'),
    WireSymbol('przewód do instalacji samochodowych', '-S'),
  ],
  '8. Telekomunikacyjne': [
    WireSymbol('stacyjny', 'TKS'),
    WireSymbol('miejscowy', 'TKM'),
    WireSymbol('instalacyjny', 'J-'),
    WireSymbol('słąboprądowy', 'T'),
    WireSymbol('do sygnałów alarmowych', 'TKS'),
  ],
  '9. Komputerowe': [
    WireSymbol('skrętka nieekranowana', 'UTP'),
    WireSymbol('skrętka ekranowana', 'FTP'),
    WireSymbol('skrętka ekranowana parami', 'STP'),
    WireSymbol('skrętka ekranowana parami + ekran wspólny', 'S-STP'),
  ],
  '10. Optotelekomunikacyjne': [
    WireSymbol('rozetowy', 'OTKr'),
    WireSymbol('tubowy', 'OTKt'),
  ],
};

const Map<String, List<WireSymbol>> wireSymbolsHarmonized = {
 '1. Rodzaj standardu': [
   WireSymbol('zharmonizowany', 'H'),
   WireSymbol('krajowy autoryzowany', 'A'),
   WireSymbol('krajowy nieautoryzowany', 'N'),
 ],
  '2. Napięcie znamionowe': [
    WireSymbol('100/100 V', '01'),
    WireSymbol('300/300 V', '03'),
    WireSymbol('300/500 V', '05'),
    WireSymbol('450/750 V', '07'),
    WireSymbol('600/1000 V', '11'),
  ],
  '3. Materiał izolacji': [
    WireSymbol('guma etylenowo-propylenowa (EPR)', 'B'),
    WireSymbol('polietylen o małej gęstości (LDPE)', 'E'),
    WireSymbol('polietylen o dużej gęstości (HDPE)', 'E2'),
    WireSymbol('etylen / octan winylu (EVA)', 'G'),
    WireSymbol('guma chloroprenowa', 'N'),
    WireSymbol('guma z kauczku naturalnego lub syntetycznego', 'R'),
    WireSymbol('guma silikonowa', 'S'),
    WireSymbol('polwinit (PVC)', 'V'),
    WireSymbol('polwinit (PVC) ciepłoodporny', 'V2'),
    WireSymbol('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbol('polwinit (PVC) usieciowany', 'V4'),
    WireSymbol('polietylen usieciowany (XLPE)', 'X'),
  ],
  '4. Materiał powłoki': [
    WireSymbol('guma etylenowo-propylenowa (EPR)', 'B'),
    WireSymbol('etylen / octan winylu (EVA)', 'G'),
    WireSymbol('guma chloroprenowa', 'N'),
    WireSymbol('guma z kauczku naturalnego lub syntetycznego', 'R'),
    WireSymbol('guma silikonowa', 'S'),
    WireSymbol('oplot z włókna szklanego (GFB)', 'J'),
    WireSymbol('oplot bawełniany', 'T'),
    WireSymbol('polwinit (PVC)', 'V'),
    WireSymbol('polwinit (PVC) ciepłoodporny', 'V2'),
    WireSymbol('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbol('polwinit (PVC) usieciowany', 'V4'),
    WireSymbol('polwinit (PVC) olejoodporny', 'V5'),
  ],
  '5. Budowa zewnętrzna': [
    WireSymbol('przewód okrągły', 'brak'),
    WireSymbol('przewód płaski, podzielny', 'H'),
    WireSymbol('przewód płaski, niepodzielny', 'H2'),
    WireSymbol('dwa lub więcej rdzeni skręconych ze sobą', 'H5'),
    WireSymbol('izolacja dwuwarstwowa', 'H7'),
    WireSymbol('przewód spiralny', 'H8'),
  ],
  '6. Budowa żyły': [
    WireSymbol('drut', 'U'),
    WireSymbol('linka, sztywna', 'R'),
    WireSymbol('linka, do przewodów spawalniczych', 'D'),
    WireSymbol('linka, do układania na stałe', 'K'),
    WireSymbol('linka, do odbiorników ruchomych', 'F'),
    WireSymbol('linka cienkodrutowa, bardzo giętka', 'H'),
    WireSymbol('lica szychowa, bardzo giętka', 'Y'),
  ],
  '7. Liczba żył w przewodzie': [
    WireSymbol('jedna', '1'),
    WireSymbol('dwie', '2'),
    WireSymbol('...', '...'),
  ],
  '8. Żyła ochronna': [
    WireSymbol('brak żyły ochronnej', 'X'),
    WireSymbol('z żyłą ochronną', 'G'),
  ],
  '9. Przekrój znamionowy żył': [
    WireSymbol('przekrój każdej żyły: 0,5 mm\u00B2', '0,5'),
    WireSymbol('przekrój każdej żyły: 0,75 mm\u00B2', '0,75'),
    WireSymbol('przekrój każdej żyły: 1 mm\u00B2', '1'),
    WireSymbol('...', '...'),
  ],
};


class WireSymbol {
  final String description;
  final String symbol;

  const WireSymbol(this.description, this.symbol);

  List<String> toRow() {
    return [description, symbol];
  }
}