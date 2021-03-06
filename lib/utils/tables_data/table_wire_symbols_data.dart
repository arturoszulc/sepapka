
const Map<String, List<WireSymbol>> wireSymbolsPolish = {
  'Budowa żyły': [
    WireSymbol('drut', 'D'),
    WireSymbol('linka', 'L'),
    WireSymbol('linka giętka', 'Lg'),
  ],
  'Materiał żyły': [
    WireSymbol('miedź', 'brak'),
    WireSymbol('aluminium', 'A'),
  ],
  'Typ': [
    WireSymbol('przewód', 'brak'),
    WireSymbol('kabel', 'K'),
  ],
  'Materiał izolacji lub powłoki': [
    WireSymbol('polwinit', 'Y'),
    WireSymbol('polwinit samogasnący', 'Yn'),
    WireSymbol('polwinit benzenopodobny', 'Yb'),
    WireSymbol('polietylen niesieciowany', 'X'),
    WireSymbol('polietylen sieciowany', 'XS'),
    WireSymbol('polietylen z zaporą przeciwwilgociową', 'Xz'),
    WireSymbol('polietylen piankowy', 'Xp'),
    WireSymbol('guma (opona)', 'O'),
  ],
  'Pancerz': [
    WireSymbol('taśma stalowa', 'Ft'),
    WireSymbol('taśma stalowa lakierowana', 'Ftl'),
    WireSymbol('taśma z drutów stalowych okrągłych', 'Fo'),
    WireSymbol('taśma z drutów stalowych płaskich', 'Fp'),
  ],
  'Ekran': [
    WireSymbol('wspólny', 'ekw'),
    WireSymbol('pary indywidualnie ekranowane', 'ekp'),
    WireSymbol('taśma', 'ekt'),
    WireSymbol('drut', 'eko'),
  ],
  'Oznaczenie dodatkowe': [
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
  'Do odbiorników ruchomych i przenośnych': [
    WireSymbol('sznur mieszkaniowy', 'SM'),
    WireSymbol('przewód oponowy warsztatowy', 'OW'),
    WireSymbol('przewód oponowy mieszkaniowy', 'OM'),
    WireSymbol('przewód oponowy przemysłowy', 'OP'),
    WireSymbol('przewód radiofoniczny', 'RP'),
    WireSymbol('przewód do instalacji samochodowych', '-S'),
  ],
  'Telekomunikacyjne': [
    WireSymbol('stacyjny', 'TKS'),
    WireSymbol('miejscowy', 'TKM'),
    WireSymbol('instalacyjny', 'J-'),
    WireSymbol('słąboprądowy', 'T'),
    WireSymbol('do sygnałów alarmowych', 'TKS'),
  ],
  'Komputerowe': [
    WireSymbol('skrętka nieekranowana', 'UTP'),
    WireSymbol('skrętka ekranowana', 'FTP'),
    WireSymbol('skrętka ekranowana parami', 'STP'),
    WireSymbol('skrętka ekranowana parami + ekran wspólny', 'S-STP'),
  ],
  'Optotelekomunikacyjne': [
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
    WireSymbol('polwinit (PVC) ciepłoodporny (90\u00B0C)', 'V2'),
    WireSymbol('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbol('polwinit (PVC) usieciowany', 'V4'),
    WireSymbol('polietylen usieciowany (XLPE)', 'X'),
    WireSymbol('usieciowana mieszanka poliolefinowa (PHC-AH)', 'Z'),
    WireSymbol('termoplastyczna mieszanka poliolefinowa (PHC-AH)', 'Z1'),
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
    WireSymbol('polwinit (PVC) ciepłoodporny (90\u00B0C)', 'V2'),
    WireSymbol('polwinit (PVC) mrozoodporny', 'V3'),
    WireSymbol('polwinit (PVC) usieciowany', 'V4'),
    WireSymbol('polwinit (PVC) olejoodporny', 'V5'),
    WireSymbol('usieciowana mieszanka poliolefinowa (PHC-AH)', 'Z'),
    WireSymbol('termoplastyczna mieszanka poliolefinowa (PHC-AH)', 'Z1'),
  ],
  '5. Budowa zewnętrzna': [
    WireSymbol('przewód okrągły', 'brak'),
    WireSymbol('przewód płaski, podzielny', 'H'),
    WireSymbol('przewód płaski, niepodzielny', 'H2'),
    WireSymbol('dwa lub więcej rdzeni skręconych ze sobą', 'H5'),
    WireSymbol('izolacja dwuwarstwowa', 'H7'),
    WireSymbol('przewód spiralny', 'H8'),
    WireSymbol('oplot ekranujący z drutu miedzianego', 'C4'),
  ],
  '6. Budowa żyły': [
    WireSymbol('jednodrutowa (kl. 1)', 'U'),
    WireSymbol('wielodrutowa, sztywna (kl. 2)', 'R'),
    WireSymbol('linka, do przewodów spawalniczych (kl. 5)', 'D'),
    WireSymbol('linka, do układania na stałe (kl. 5)', 'K'),
    WireSymbol('linka, do odbiorników ruchomych (kl. 5)', 'F'),
    WireSymbol('linka cienkodrutowa, bardzo giętka (kl. 6)', 'H'),
    WireSymbol('lica szychowa, bardzo giętka (kl. 6)', 'Y'),
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