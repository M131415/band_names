class Band {
  final String id;
  final String name;
  final int votes;

  Band({required this.id, required this.name, required this.votes});

  // Regresa una nueva instancia de mi clase
  factory Band.fromMap(Map<String, dynamic> obj) 
  => Band(
    id: obj['id'],
    name: obj['name'],
    votes: obj['votes'],
  );
}