

class AppState {
  final bool isLoading;
  final bool isSignedIn;
  final bool isSignedOut;
  final bool signInError;

  AppState({
    required this.isLoading,
    required this.isSignedIn,
    required this.isSignedOut,
    required this.signInError});

  factory AppState.initial() {
    return AppState(
        isLoading: true,
        isSignedIn: false,
        isSignedOut: false,
        signInError: false);
  }

  AppState copyWith({
    bool? isLoading,
    bool? isSignedIn,
    bool? isSignedOut,
    bool? signInError,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isSignedOut: isSignedOut ?? this.isSignedOut,
        signInError: signInError ?? this.signInError,
    );
  }
}