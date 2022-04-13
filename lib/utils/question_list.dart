import 'package:sepapka/model_layer/models/question.dart';


//przycisk dodający pytania to SIGN OUT

final questionListDB = [

  Question( id:'epoDl89w4G4cRcNFrG7Y', q: 'Przez który z wymienionych przewodów, w warunkach normalnych, nie płynie prąd', a1: 'ochronny PE', a2: 'neutralny N', a3: 'fazowy L', a4: 'środkowy M', label: 3, level: 1, assetPath: ''),
  Question( id:'AMJEwqpt0BFHrFPBfOa9', q: 'Widoczny na poniższym rysunku układ sieci to', a1: 'sieć TN-S', a2: 'sieć TT', a3: 'sieć TN-C', a4: 'sieć IT', label: 3, level: 1, assetPath: 'uklad_sieci_tns.png'),
  Question( id:'PLVwRwFHsGpH0Wht6A8I', q: 'W Polsce wartości napięć instalacji elektrycznej w budynkach mieszkalnych wynoszą obecnie', a1: '230/400 V', a2: '220/380 V', a3: '110/220 V', a4: '230/230 V', label: 3, level: 1, assetPath: ''),
  Question( id:'byUIns8tvzPsYtTEqGDQ', q: 'W przewodzie pięciożyłowym, wyposażonym w żyłę ochronną o barwie żółto-zielonej, poszczególne żyły fazowe powinny być oznaczone barwami', a1: 'brązową, czarną, szarą', a2: 'brązową, czarną, czerwoną', a3: 'czarną, szarą, białą', a4: 'żółtą, zieloną, białą', label: 3, level: 1, assetPath: ''),
  Question( id:'fsZjPohRT77i8mbkxSlx', q: 'Żadna instalacja elektryczna nie może się obyć bez przewodu', a1: 'fazowego L', a2: 'neutralnego N', a3: 'ochronno-neutralnego PEN', a4: 'ochronnego PE', label: 3, level: 1, assetPath: ''),
  Question( id:'BVdNs3VTxzyXEvNqbTPR', q: 'Barwą jasnoniebieską na całej długości i dodatkowo zielono-żółtymi znacznikami przy końcach może być oznaczany przewód', a1: 'ochronno-neutralny PEN', a2: 'ochronny PE', a3: 'neturalny N', a4: 'fazowy L', label: 3, level: 2, assetPath: ''),
  Question( id:'hwJtge8rwYPwImfFbqxj', q: 'Do grupy bardzo niskich napięć (ang. Extra-low voltage) NIE należy', a1: 'NELV', a2: 'PELV', a3: 'SELV', a4: 'FELV', label: 3, level: 2, assetPath: ''),
  Question( id:'hLh3TeTsKVqzu7NK6Vno', q: 'Aby przejść z układu sieci TN-C na TN-S należy', a1: 'rozdzielić przewód PEN na PE i N', a2: 'odwrócić kolejność faz', a3: 'odłączyć uziemienie ', a4: 'połączyć przewód żółto-zielony z brązowym ', label: 3, level: 2, assetPath: ''),
  Question( id:'NMnclsvXakaQnME7jmbr', q: 'Trójfazowa sieć typu TN-C jest siecią ', a1: 'czteroprzewodową ', a2: 'trójprzewodową ', a3: 'pięcioprzewodową ', a4: 'sześcioprzewodową', label: 3, level: 2, assetPath: ''),
  Question( id:'ihwR1lnQsaHu3suh00bf', q: 'Który z układów sieci jest niedopuszczalny ze względów bezpieczeństwa? ', a1: 'TN-S-C ', a2: 'TN-C-S', a3: 'TN-C', a4: 'TN-S', label: 3, level: 3, assetPath: ''),
  Question( id:'lGxb00taZrK8uFvgMnUG', q: 'Do głównej szyny uziemiajacej nie można podłączyć ', a1: 'Przewodu fazowego ', a2: 'Przewodu ochronnego ', a3: 'Przewodu połączeń wyrównawczych ', a4: 'Uziemienia roboczego', label: 3, level: 2, assetPath: ''),
  Question( id:'hZI5ovUdlqGYBGjmsVEb', q: 'Przewód ochronny PE nie może łączyć części przewodzących dostępnych z', a1: 'częścią czynną', a2: 'punktem neutralnym transformatora', a3: 'uziomem ochronnym', a4: 'główną szyną uziemiającą', label: 3, level: 3, assetPath: ''),
  Question( id:'YBbQOvUvidcDJ8wDB3tv', q: 'Połączenie oznaczone gwiazdką (*) jest', a1: 'niedopuszczalne', a2: 'dozwolone', a3: 'dozwolone tylko na obiektach przemysłowych', a4: 'dozwolone za wyjątkiem obiektów przemysłowych', label: 3, level: 3, assetPath: 'polaczenie_pe_n.png'),
  Question( id:'hkm0QzhpEaQMWTYtyCcI', q: 'Część przewodząca urządzenia lub instalacji elektrycznej, która może znaleźć się pod napięciem w warunkach normalnej pracy to', a1: 'część czynna', a2: 'część bierna', a3: 'część ekwipotencjalna', a4: 'część izolowana', label: 2, level: 1, assetPath: ''),
  Question( id:'kgrlDOI8acwC0mFrTz1k', q: 'Dotknięcie przez człowieka lub zwierzę części czynnej to', a1: 'dotyk bezpośredni', a2: 'dotyk pośredni', a3: 'dotyk udarowy', a4: 'dotyk przejściowy', label: 2, level: 1, assetPath: ''),
  Question( id:'lLrLaaYMQTgZFi75Ca4b', q: 'Dotknięcie części przewodzącej dostępnej, która znalazła się pod napięciem w wyniku uszkodzenia (np. izolacji), to', a1: 'dotyk pośredni', a2: 'dotyk bezpośredni', a3: 'dotyk niezamierzony', a4: 'dotyk przypadkowy', label: 2, level: 1, assetPath: ''),
  Question( id:'kSQxIViEpGPUUGEaBItC', q: 'Ochrony przez samoczynnie wyłączenie zasilania NIE może realizować', a1: 'rozłącznik izolacyjny', a2: 'bezpiecznik topikowy', a3: 'wyłącznik nadprądowy', a4: 'wyłącznik różnicowoprądowy', label: 2, level: 3, assetPath: ''),
  Question( id:'YfPHiLTj5VJQ60gmZ1bK', q: 'Który z przewodów możemy zaliczyć do grupy tzw. części czynnych?', a1: 'neutralny N', a2: 'ochronny PE', a3: 'ochronno-neutralny PEN ', a4: 'uziemiający PEL', label: 2, level: 2, assetPath: ''),
  Question( id:'estYcpCM68CY2e6Jh78R', q: 'Który z symboli dotyczy stopnia ochrony osłony lub obudowy urządzenia przed dostępem człowieka i wnikaniem wody?', a1: 'IP48', a2: 'AD2', a3: 'IK05', a4: 'IEC529', label: 4, level: 2, assetPath: ''),
  Question( id:'Rw6DoNprhXRUY2dSVbh0', q: 'Której klasy ochronności urządzeń elektrycznych dotyczy poniższy symbol?', a1: 'klasy II', a2: 'klasy 0', a3: 'klasy I', a4: 'klasy III', label: 4, level: 2, assetPath: 'klasa_II_ochronnosci.png'),
  Question( id:'eQgeDoaX37agSq5ki91l', q: 'Urządzenia III klasy ochronności mogą być zasilanie napięciem', a1: 'SELV lub PELV', a2: 'przemiennym do 230 V', a3: 'stałym do 230 V', a4: 'przemiennym do 1 kV', label: 4, level: 3, assetPath: ''),
  Question( id:'EVGbjRBq2mpOOncNexX8', q: 'WLZ to skrót od', a1: 'wewnętrzna linia zasilająca', a2: 'wysokonapięciowa linia zasilająca', a3: 'wewnętrzna listwa zasilająca', a4: 'wysokonapięciowa listwa zasilająca', label: 1, level: 1, assetPath: ''),
  Question( id:'dfuvYijYLDtZfyVxEwk5', q: 'Przewód, który zapewnia wyrównanie potencjałów części przewodzących, do których jest podłączony, to', a1: 'przewód wyrównawczy', a2: 'przewód uziemiający', a3: 'przewód neutralny', a4: 'przewód ochronny', label: 1, level: 2, assetPath: ''),
  Question( id:'S7xAmOOTrxNyBSdj5L5d', q: 'Przewód łączący uziom z główną szyną uziemiającą to', a1: 'przewód uziemiający', a2: 'przewód wyrównawczy', a3: 'przewód roboczy', a4: 'przewód środkowy', label: 1, level: 2, assetPath: ''),


];
