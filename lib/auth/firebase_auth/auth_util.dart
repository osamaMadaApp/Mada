import 'firebase_auth_manager.dart';

export 'firebase_auth_manager.dart';

final _authManager = FirebaseAuthManager();
FirebaseAuthManager get authManager => _authManager;

String get currentUserEmail => currentUser?.email ?? '';

String get currentUserUid => currentUser?.uid ?? '';

String get currentUserDisplayName => currentUser?.displayName ?? '';

String get currentUserPhoto => currentUser?.photoUrl ?? '';

String get currentPhoneNumber => currentUser?.phoneNumber ?? '';

bool get currentUserEmailVerified => currentUser?.emailVerified ?? false;
