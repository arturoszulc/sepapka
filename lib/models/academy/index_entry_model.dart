

const List<IndexEntry> indexList = [
  IndexEntry(title: 'uziom',description: 'element metalowy tworzący elektryczne połączenie z gruntem (np. pręt wbity w ziemię)', translation: 'earth electrode, ground electrode'),
  IndexEntry(title: 'uziom fundamentowy',description: '- taśma lub pręt stalowy zatopiony w betonie (uziom fundamentowy sztuczny)\n- stalowa konstrukcja fundamentu (uziom fundamentowy naturalny', translation: 'earth electrode embedded in foundation'),
];


class IndexEntry {
  final String title;
  final String description;
  final String translation;

  const IndexEntry({
    required this.title,
    required this.description,
    required this.translation,
  });
}