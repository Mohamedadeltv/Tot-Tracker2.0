class SignInWithEmailAndPasswordFailure {
  final String message;
  const SignInWithEmailAndPasswordFailure(
      [this.message = "An unknown error occurred"]);
  factory SignInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
            'There is no account associated with this email address');
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure('Wrong password');
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
            'This account has been disabled. Please contact support for help');
      default:
        return const SignInWithEmailAndPasswordFailure();
    }
  }
}
