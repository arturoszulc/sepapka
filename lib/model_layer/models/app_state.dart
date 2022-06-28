class AppState {
  final bool isLoading;
  final bool isSignedIn;
  final bool isSignedOut;
  final bool signInError;

  final bool isQuizFinished;

  AppState(
      {required this.isLoading,
      required this.isSignedIn,
      required this.isSignedOut,
      required this.signInError,
      required this.isQuizFinished});

  factory AppState.initial() {
    return AppState(
      isLoading: true,
      isSignedIn: false,
      isSignedOut: false,
      signInError: false,
      isQuizFinished: false,
    );
  }

  AppState copyWith({
    bool? isLoading,
    bool? isSignedIn,
    bool? isSignedOut,
    bool? signInError,
    bool? isQuizFinished,
  }) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isSignedOut: isSignedOut ?? this.isSignedOut,
      signInError: signInError ?? this.signInError,
      isQuizFinished: isQuizFinished ?? this.isQuizFinished,
    );
  }
}
