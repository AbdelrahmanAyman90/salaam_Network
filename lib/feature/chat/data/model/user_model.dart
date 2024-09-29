class UserModel {
  String name;
  String email; // Corrected the spelling from 'emial' to 'email'
  String userId; // Corrected the spelling from 'UserId' to 'userId'
  String? lastSean;
  UserModel(
      {required this.userId,
      required this.email,
      required this.name,
      required this.lastSean});

  // Factory constructor to create a UserModel from a Firestore document
  factory UserModel.fromDocument(Map<String, dynamic> doc) {
    return UserModel(
        userId: doc['id'], // Adjust based on your document structure
        email: doc['email'], // Ensure the field names match
        name: doc['name'],
        lastSean: doc['lastSean']);
  }
  // Convert UserModel to a Map (for Firestore or other purposes)
  Map<String, dynamic> toMap() {
    return {
      'id': userId,
      'email': email,
      'name': name,
    };
  }
}
