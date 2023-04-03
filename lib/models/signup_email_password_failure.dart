class SignUpWithEmailAndPasswordFailure {
  final String message;
  const SignUpWithEmailAndPasswordFailure(
      [this.message = "An unknown error occured"]);
  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'week-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Please enter a stronger password');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email is not valid or badly formatted');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'an account already exists for that email');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'operation is not allowed please contact support ');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'This user has been disabled. please contact support for help');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}
