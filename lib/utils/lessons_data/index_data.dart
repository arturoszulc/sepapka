import '../../models/academy/index_entry_model.dart';

const List<IndexEntry> indexList = [
  IndexEntry(title: 'bardzo niskie napięcie',description: 'napięcie, którego wartość nie przekracza:\n- 50 V (napięcie przemienne)\n-120 V (napięcie stałe).\nW skrócie: napięcie niegroźne dla człowieka', translation: 'extra-low voltage'),
  IndexEntry(title: 'bariera (przeszkoda)',description: 'Element chroniący przed niezamierzonym dotykiem bezpośrednim.', translation: 'obstacle'),
  IndexEntry(title: 'bezpieczeństwo',description: 'Stan, w którym nie występuje nieakceptowane ryzyko szkód (choć jakieś ryzyko zawsze istnieje)', translation: 'safety'),
  IndexEntry(title: 'część czynna',description: 'Element przewodzący, który w czasie normalnej pracy może się znaleźć pod napięciem.\nCzęścią czynną jest na przykład przewód fazowy (L) oraz neutralny (N).\nDo części czynnych nie zaliczamy m. in. przewodu ochronnego (PE), przewodu ochronno-neutralnego (PEN), metalowych obudów i konstrukcji', translation: 'live part'),
  IndexEntry(title: 'część przewodzaca dostępna',description: 'Element przewodzący, łatwo dostępny, który w wyniku awarii/uszkodzenia może znaleźć się pod napięciem (np. metalowa obudowa urządzenia).', translation: 'exposed conductive part'),
  IndexEntry(title: 'część przewodzaca obca',description: 'Element przewodzący, niebędący częścią instalacji elektrycznej (ale mogący się nieopatrznie taką częścią stać).\nNa przykład metalowa rura wychodząca z ziemi w pobliżu naszej rozdzielnicy. Niby nie ma ona z naszą siecią nic wspólnego, a jednak oparcie się o nią i jednoczesne dotknięcie przewodu fazowego w rozdzielnicy źle się dla nas skończy.', translation: 'extraneous conductive part'),
  IndexEntry(title: 'części jednocześnie dostępne',description: 'Elementy przewodzące, które możemy dotknąć jednocześnie.\nMogą to być zarówno części czynne, przewodzące dostępne i obce, a także przewody ochronne i uziomy.', translation: 'simultaneously accessible parts'),
  IndexEntry(title: 'dotyk bezpośredni',description: 'Inaczej: dotknięcie części czynnej (czyli przewodnika znajdującego się pod napięciem).', translation: 'direct contact'),
  IndexEntry(title: 'dotyk pośredni',description: 'Inaczej: dotknięcie części przewodzącej dostęnej, która w wyniku uszkodzenia znalazła się pod napięciem.', translation: 'indirect contact'),
  IndexEntry(title: 'ekwipotencjalność',description: 'Stan, w którym kilka przewodników ma ten sam potencjał elektryczny.', translation: 'equipotentiality'),
  IndexEntry(title: 'FELV',description: 'Bardzo niskie napięcie funkcjonalne.', translation: 'functional extra-low voltage'),
  IndexEntry(title: 'główna szyna uziemiająca',description: 'W skrócie: GSU. Metalowa szyna, za pomocą której łączymy z uziomem wszelkie przewody ochronne i wyrównawcze', translation: 'main earthing terminal, groundbus'),
  IndexEntry(title: 'impedancja uziemienia',description: 'Impedancja mierzona między dowolnym punktem sieci/instalacji/urządzenia, a potencjałem ziemi', translation: 'impedance of earth'),
  IndexEntry(title: 'instalacja elektryczna',description: 'Zespół urządzeń elektrycznych, służący dostarczaniu energii elektrycznej z sieci rozdzielczej do odbiorników', translation: 'electrical installation'),
  IndexEntry(title: 'instalacja uziemiająca',description: 'Zespół urządzeń elektrycznych, służący do uziemienia sieci i/lub instalacji (np. przewody wyrównawcze, ochronne, GSU)', translation: 'earthing (grounding) arrangement'),
  IndexEntry(title: 'izolacja dodatkowa',description: 'Pokrywa się nią izolację podstawową, w celu dodatkowej ochrony przed porażeniem', translation: 'suplementary insulation'),
  IndexEntry(title: 'izolacja podstawowa',description: 'Pokrywa się nią część czynną (np. żyłę przewodu) w celu ochrony przed dotykiem bezpośrednim (np. dotknięciem żyły będącej pod napięciem)', translation: 'basic insulation'),
  IndexEntry(title: 'izolacja podwójna',description: 'Izolacja składająca się z izolacji podstawowej i dodatkowej', translation: 'double insulation'),
  IndexEntry(title: 'izolacja wzmocniona',description: 'Alternatywa dla izolacji podwónej. ', translation: 'reinforced insulation'),
  IndexEntry(title: 'napięcie bezpieczne',description: 'Nazwa wyszła z użycia. Patrz: napięcie dotykowe dopuszczalne.', translation: 'safe voltage'),
  IndexEntry(title: 'napięcie dotykowe',description: 'Napięcie pojawiające się między częściami jednocześnie dostępnymi, w wyniku uszkodzenia izolacji', translation: 'touch voltage'),
  IndexEntry(title: 'napięcie dotykowe dopuszczalne',description: 'Dawniej: napięcie bezpieczne.\nWartość napięcia, którego długotrwałe utrzymywanie się nie stanowi zagrożenia dla człowieka. W praktyce: 50 V napięcia przemiennego lub 120 V napięcia stałego', translation: 'conventional touch voltage limit'),
  IndexEntry(title: 'napięcie względem ziemi',description: 'Napięcie między przewodem fazowym, a ziemią odniesienia, w danym punkcie obwodu elektrycznego', translation: 'line-to-earth voltage, line-to-ground voltage'),
  IndexEntry(title: 'napięcie znamionowe instalacji',description: 'Wartość napięcia na jaką dana instalacja została zaprojektowana (np. 230/400 V w przypadku instalacji w budynkach mieszkalnych)', translation: 'nominal voltage of an installation'),
  IndexEntry(title: 'obciążalność prądowa długotrwała przewodu',description: 'Prąd, którego długotrwały przepływ nie doprowadzi do przekroczenia dopuszczalnej temperatury przewodu.\nWartość ta zależy nie tylko od rodzaju przewodu, ale i warunków zewnętrznych', translation: 'current-carrying capacity of conductor'),
  IndexEntry(title: 'obudowa',description: 'Element konstrukcyjny zapewniający ochronę urządzenia przed dotykiem bezpośrednim, a także wybranymi warunkami zewnętrznymi', translation: 'enclosure'),
  IndexEntry(title: 'obwód instalacji elektrycznej',description: 'Zbiór elementów instalacji elektrycznej zasilanych z tego samego punktu, chronionych wspólnym zabezpieczeniem.', translation: 'electrical circuit of an installation'),
  IndexEntry(title: 'obwód odbiorczy obiektu budowlanego',description: 'Obwód, do którego bezpośrednio podłączone są odbiorniki energii elektrycznej (w tym gniazda wtyczkowe)', translation: 'final circuit buildings, branch circuit'),
  IndexEntry(title: 'obwód rozdzielczy obiektu budowlanego',description: 'Obwód zasilający rozdzielnicę (tablicę rozdzielczą)', translation: 'distribution circuit of buildings'),
  IndexEntry(title: 'ochrona dodatkowa (ochrona przy dotyku pośrednim, ochrona przy uszkodzeniu)',description: 'Ochrona przed porażeniem elektrycznym wynikającym z wystąpienia awarii/uszkodzenia.\nDo środków ochrony dodatkowej należą m. in. bezpieczniki, wyłaczniki nadprądowe i wyłączniki różnicowo-prądowe, ', translation: 'fault protection'),
  IndexEntry(title: 'ochrona podstawowa (ochrona przy dotyku bezpośrednim)',description: 'Ochrona zapobiegająca porażeniu przez dotknięcie części czynnej.\nDo środków ochrony podstawowej należą m. in. izolacja przewodu, bariera, obudowa', translation: 'basic protection'),
  IndexEntry(title: 'ochrona przeciwporażeniowa',description: 'Zespół środków ochrony ograniczający ryzyko porażenia prądem', translation: 'protection against electric shock'),
  IndexEntry(title: 'odbiornik energii elektrycznej',description: 'Urządzenie elektryczne przetwarzające energię elektryczną w inną formę energii (np. silnik elektryczny)', translation: 'current-using equipment'),
  IndexEntry(title: 'ogrodzenie',description: 'Zapewnia ochronę przed niezamierzonym dotykiem bezpośrednim ze wszystkich ogólnie dostępnych stron.', translation: 'barrier'),
  IndexEntry(title: 'oprzewodowanie',description: 'Przewód/przewody oraz wszystkie elementy zapewniające jego/ich mocowanie i ochronę przed uszkodzeniami', translation: 'wiring system'),
  IndexEntry(title: 'osłona',description: 'Zapewnia ochronę przed umyślnym dotknięciem części czynnej (części pod napięciem).\nAby element uznać za osłonę, jego stopień ochrony musi wynosić przynajmniej IP2X lub IPXXB.', translation: 'enclosure'),
  IndexEntry(title: 'osoba poinstruowana',description: 'Osoba, która za sprawą pouczenia lub nadzoru osób wykwalifikowanych potrafi ocenić zagrożenie i uniknąć niebezpieczeństwa podczas pracy', translation: 'instructed person'),
  IndexEntry(title: 'osoba postronna',description: 'Osoba, która nie jest ani poinstruowana, ani wykwalifikowana.', translation: 'ordinary person'),
  IndexEntry(title: 'osoba wykwalifikowana',description: 'Osoba przeszkolona i doświadczona, która na podstawie własnej wiedzy potrafi ocenić zagrożenie i uniknąć niebezpieczeństwa podczas pracy', translation: 'skilled person'),
  IndexEntry(title: 'PELV',description: 'Bardzo niskie napięcie ochronne', translation: 'protective extra-low voltage'),
  IndexEntry(title: 'połączenie wyrównawcze',description: 'Połączenie części przewodzących (zarówno dostępnych jak i obcych) w celu wyrównania ich potencjałów', translation: 'equipotential bonding'),
  IndexEntry(title: 'porażenie prądem elektrycznym',description: 'Stan, w którym przepływ prądu przez organizm człowieka lub zwierzęcia wywołuje skutki patofizjologiczne', translation: 'electric shock'),
  IndexEntry(title: 'porażenie śmiertelne',description: 'porażenie prądem elektrycznym ze skutkiem śmiertelnym', translation: 'electrocution'),
  IndexEntry(title: 'prąd dotykowy',description: 'Prąd płynący przez człowieka lub zwierzę, wywołany dotknięciem części przewodzącej, znajdującej się pod napięciem', translation: 'touch current'),
  IndexEntry(title: 'prąd obliczeniowy obwodu',description: 'Prąd przewidywany w danym obwodzie elektrycznym', translation: 'design current of a circuit'),
  IndexEntry(title: 'prąd przeciążeniowy w obwodzie',description: 'Prąd przetężeniowy płynący pomimo braku jakiegokolwiek uszkodzenia w obwodzie', translation: 'overload current of a circuit'),
  IndexEntry(title: 'prąd przetężeniowy',description: 'Prąd większy niż znamionowy prąd przewidziany dla danego obwodu.\nZnamionowy prąd obwodu możemy wyznaczyć na podstawie obciążalności długotrwałej przewodu, który ten obwód zasila', translation: 'overcurrent'),
  IndexEntry(title: 'prąd rażeniowy',description: 'Prąd wywołujący porażenie elektryczne, czyli wystąpienie skutków patofizjologicznych w organizmie człowieka lub zwierzęcia', translation: 'shock current'),
  IndexEntry(title: 'prąd różnicowy',description: 'Najprościej mówiąc: prąd płynący poza przewodami czynnymi, np. w przewodzie ochronnym, w skutek awarii. W przypadku braku awarii prąd różnicowy jest równy zero.\n\nDefinicja: prąd o wartości chwilowej równej sumie algebraicznej wartości chwilowych prądów płynących we wszystkich przewodach czynnych w określonym miejscu sieci lub instalacji elektrycznej; w urządzeniach napięcia przemiennego wartość skuteczna prądu różnicowego jest sumą geometryczną (wektorową) wartości skutecznych prądów płynących we wszystkich przewodach czynnych', translation: 'residual current'),
  IndexEntry(title: 'prąd umowny zadziałania urządzenia zabezpieczającego',description: 'wartość prądu powodująca zadziałanie zabezpieczenia w tzw. czasie umownym zadziałania', translation: 'conventional operating current of a protective device'),
  IndexEntry(title: 'prąd upływowy',description: 'Prąd, który mimo braku zwarcia, płynie od części czynnych do ziemi.\nSytuacja spotykana wszędzie tam, gdzie stosowane są różnego rodzaju przemienniki częstotliwości (np. falowniki silników trójfazowych)', translation: 'leakage current'),
  IndexEntry(title: 'prąd uziomowy',description: 'Prąd płynący przez dany uziom w wyniku zwarcia doziemnego', translation: 'earthing current'),
  IndexEntry(title: 'prąd wyłączający',description: 'Najmniejszy prąd wywołujący (w wymaganym czasie) samoczynne wyłączenie zasilania (czyli zadziałanie zabezpieczenia przetężeniowego lub RCD)', translation: 'cut-off current'),
  IndexEntry(title: 'prąd zwarciowy przy zwarciu metalicznym',description: 'Prąd płynący podczas bezpośedniego zetknięcia się dwóch przewodów o różnych potencjałach', translation: 'solid short-circuit current'),
  IndexEntry(title: 'przewód neutralny',description: 'Przewód połączony bezpośrednio z punktem neutralnym układu sieci. Może przesyłać energię elektryczną', translation: 'neutral wire'),
  IndexEntry(title: 'przewód ochronno-neutralny (PEN)',description: 'Uziemiony przewód pełniący jednocześnie rolę przewodu neutralnego (N) i ochronnego (PE)', translation: 'PEN conductor'),
  IndexEntry(title: 'przewód ochronny (PE)',description: 'Uziemiony przewód, przez który w warunkach normalnej pracy sieci/instalacji nie płynie prąd.\nPrzewód wykorzystywany w realizacji ochrony dodatkowej (ochrony przed dotykiem pośrednim)', translation: 'protective conductor'),
  IndexEntry(title: 'przewód uziemiający',description: 'Przewód łączący główną szynę uziemiającą (GSU) z uziomem', translation: 'earthing conductor, grounding electrode conductor'),
  IndexEntry(title: 'przewód wyrównawczy',description: 'Przewód mający zapewnić ekwiptencjalnośc (wyrównanie potencjałów połączonych nim części przewodzących)', translation: 'equipotential bonding conductor'),
  IndexEntry(title: 'rezystancja uziemienia',description: 'Rezystancja między zaciskiem uziemienia, a ziemią odniesienia', translation: 'resistance of earth, resistance to ground'),
  IndexEntry(title: 'samoczynne wyłączenie zasilania',description: 'przerwanie zasilania spowodowane automatycznym zadziałaniem urządzeń zabezpieczającyh (np. wyłączników nadprądowych)', translation: 'automatic disconnection of supply'),
  IndexEntry(title: 'SELV',description: 'Bardzo niskie napięcie bezpieczne', translation: 'safety extra-low voltage'),
  IndexEntry(title: 'urządzenie elektryczne',description: 'Urządzenie przeznaczone do przetwarzania/przesyłania/przekształcania/rozdziału energii elektrycznej\nUrządzeniami elektrycznymi są wszelkie maszyny elektryczne, transformatory, odbiorniki, urządzenia pomiarowe i zabezpieczające, a nawet oprzewodowanie)', translation: 'electrical equipment'),
  IndexEntry(title: 'urządzenie przenośne',description: 'Urządzenie elektryczne przystosowane do przemieszczania i łączenia w różnych miejscach użytkowania', translation: 'portable equipment'),
  IndexEntry(title: 'urządzenie ręczne',description: 'Urządzenie przenośne przystosowane do trzymania w ręce podcas jego użytkowania', translation: 'hand-held equipment'),
  IndexEntry(title: 'urządzenie stacjonarne',description: 'Urządzenie elektryczne na tyle ciężkie, że nie może być z łatwością przemieszczane (aczkolwiek nie jest przytwierdzone do podłoża na stałe)', translation: 'stationary equipment'),
  IndexEntry(title: 'urządzenie stałe',description: 'Urządzenie elektryczne przytwierdzone do podłoża na stałe', translation: 'fixed equipment'),
  IndexEntry(title: 'uziemienie',description: 'Połączenie elektryczne z ziemią', translation: 'earthing'),
  IndexEntry(title: 'uziemienie ochronne',description: 'Specjalne uziemienie stanowiące element ochrony przed porażeniem', translation: 'protective earthing, protective grounding'),
  IndexEntry(title: 'uziom',description: 'Element metalowy tworzący elektryczne połączenie z gruntem (np. pręt wbity w ziemię)', translation: 'earth electrode, ground electrode'),
  IndexEntry(title: 'uziom fundamentowy',description: '- Taśma lub pręt stalowy zatopiony w betonie (uziom fundamentowy sztuczny)\n- Stalowa konstrukcja fundamentu (uziom fundamentowy naturalny)', translation: 'earth electrode embedded in foundation'),
  IndexEntry(title: 'uziom naturalny',description: 'Element nie stworzony do bycia uziomem, ale w tym celu wykorzystany (np. metalowa rura wodociągowa)', translation: 'natural earth electrode'),
  IndexEntry(title: 'uziom sztuczny',description: 'Element stworzony z myślą o byciu uziomem (np. metalowa szpilka wbita w ziemię)', translation: 'artificial earth electrode'),
  IndexEntry(title: 'uziomy niezależne',description: 'Uziomy umieszczone na tyle daleko od siebie, że prąd płynący w jednym z nich nie wpływa na potencjał innego', translation: 'electrically independent earth electrodes, ground electrodes'),
  IndexEntry(title: 'wewnętrzna linia zasilająca',description: 'W skrócie: WLZ. Kabel prowadzący od złącza instalacji elektrycznej do rozdzielnicy (tablicy rozdzielczej)', translation: 'distribution circuit of buildings'),
  IndexEntry(title: 'zacisk uziemiający',description: 'Zacisk, który posiada każde urządzenie wymagające uziemienia.', translation: 'earthing terminal, grounding terminal'),
  IndexEntry(title: 'zasięg ręki',description: 'Obszar wokół stanowiska pracy znajdujący się w zasięgu ręki bez użycia środków pomocniczych (takich jak drabina)', translation: 'arm\'s reach'),
  IndexEntry(title: 'ziemia',description: 'Elektryczne określenie na przewodzącą masę ziemi, której potencjał został umownie ustalony na poziomie 0 V (zero woltów)', translation: 'earth, ground'),
  IndexEntry(title: 'ziemia odniesienia',description: 'Dowolny punkt na powierzchni lub w głąb ziemi, którego potencjał nie zmienia się pod wpływem spływającego do niego prądu.', translation: 'reference earth, reference ground'),
  IndexEntry(title: 'złącze instalacji elektrycznej',description: 'urządzenie elektryczne łączące sieć rozdzielczą z instalacją elektryczną odbiorcy.\nTo co jest przed złączem należy do dystrybutora. To co jest za złączem (najcześciej WLZ) należy do odbiorcy.', translation: 'origin of an electrical installation, service entrance'),
];