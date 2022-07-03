import '../../models/academy/index_entry_model.dart';

const List<IndexEntry> indexList = [
  IndexEntry(title: 'bardzo niskie napięcie',description: 'Napięcie bezpieczne, którego wartość nie przekracza:\n- 50 V (napięcie przemienne)\n-120 V (napięcie stałe)', translation: 'extra-low voltage'),
  IndexEntry(title: 'bariera',description: 'Element chroniący przed niezamierzonym dotykiem bezpośrednim (uparty elektryk może go jednak ominąć).', translation: 'obstacle'),
  IndexEntry(title: 'bezpieczeństwo',description: 'Stan w którym nie występuje nieakceptowane ryzyko szkód (choć jakieś ryzyko zawsze istnieje)', translation: 'safety'),
  IndexEntry(title: 'część czynna',description: 'Element przewodzący, który w czasie normalnej pracy może znaleźć się pod napięciem.\nCzęścią czynną jest na przykład przewód fazowy (L) oraz neutralny (N).\nDo części czynnych nie zaliczamy przewodów ochronnego (PE) i ochronno-neutralnego (PEN), ani metalowych obudów urządzeń', translation: 'live part'),
  IndexEntry(title: 'część przewodzaca dostępna',description: 'Element przewodzący, łatwo dostępny, który w wyniku awarii/uszkodzenia może się znaleźć pod napięciem.\nKryteria te spełnia np. metalowa obudowa urządzenia, ale już nie elementy zamknięte wewnątrz tej obudowy', translation: 'exposed conductive part'),
  IndexEntry(title: 'część przewodzaca obca',description: 'Element przewodzący, niebędący częścią instalacji elektrycznej (ale mogący się nieopatrznie taką częścią stać).\nNa przykład metalowa rura wychodząca z ziemi w pobliżu naszej rozdzielnicy. Niby nie ma ona z naszą siecią nic wspólnego, a jednak oparcie się o nią i jednoczesne dotknięcie przewodu fazowego w rozdzielnicy źle się dla nas skończy.', translation: 'extraneous conductive part'),
  IndexEntry(title: 'części jednocześnie dostępne',description: 'Elementy przewodzące, które możemy dotknąć jednocześnie.\nMogą to być zarówno części czynne, przewodzące dostępne i obce, a także przewody ochronne i uziomy.', translation: 'simultaneously accessible parts'),
  IndexEntry(title: 'dotyk bezpośredni',description: 'Inaczej: dotknięcie części czynnej (czyli przewodnika znajdującego się pod napięciem).', translation: 'direct contact'),
  IndexEntry(title: 'dotyk pośredni',description: 'Inaczej: dotknięcie części przewodzącej dostęnej, która w wyniku uszkodzenia znalazła się pod napięciem.', translation: 'indirect contact'),
  IndexEntry(title: 'ekwipotencjalność',description: 'stan, w którym kilka przewodników ma ten sam potencjał elektryczny.', translation: 'equipotentiality'),
  IndexEntry(title: 'FELV',description: 'bardzo niskie napięcie funkcjonalne.', translation: 'functional extra-low voltage'),
  IndexEntry(title: 'główna szyna uziemiająca',description: 'W skrócie: GSU. Metalowa szyna za pomocą której łączymy z uziomem wszelkie przewody ochronne i wyrównawcze', translation: 'main earthing terminal, groundbus'),
  IndexEntry(title: 'impedancja uziemienia',description: 'Impedancja mierzona między dowolnym punktem sieci/instalacji/urządzenia, a potencjałem ziemi', translation: 'impedance of earth'),
  IndexEntry(title: 'instalacja elektryczna',description: 'zespół urządzeń elektrycznych, służący dostarczaniu energii elektrycznej z sieci rozdzielczej do odbiorników', translation: 'electrical installation'),
  IndexEntry(title: 'uziom',description: 'Element metalowy tworzący elektryczne połączenie z gruntem (np. pręt wbity w ziemię)', translation: 'earth electrode, ground electrode'),
  IndexEntry(title: 'uziom fundamentowy',description: '- taśma lub pręt stalowy zatopiony w betonie (uziom fundamentowy sztuczny)\n- stalowa konstrukcja fundamentu (uziom fundamentowy naturalny)', translation: 'earth electrode embedded in foundation'),
];