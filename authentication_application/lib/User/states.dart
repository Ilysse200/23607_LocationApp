class UserActionTracker {
  static final UserActionTracker _singleton = UserActionTracker._internal();
  
  factory UserActionTracker() {
    return _singleton;
  }
  
  UserActionTracker._internal();

  // Initializing with 'login' as the default action is fine,
  // but we need more flexibility to track different states.
  String lastAction = 'login'; // Can be 'login', 'admin', or 'register'

  // Method to set the user action, can be used to update the action easily
  void setUserAction(String action) {
    lastAction = action;
  }
}
