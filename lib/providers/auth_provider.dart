import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../services/supabase_service.dart';

/// Authentication states
enum AuthState {
  initial,
  authenticated,
  unauthenticated,
  loading,
  error,
}

/// Auth provider to manage authentication state throughout the app
class AuthProvider extends ChangeNotifier {
  /// The Supabase service
  final SupabaseService _supabaseService = SupabaseService();
  
  /// Current authentication state
  AuthState _authState = AuthState.initial;
  
  /// Error message if authentication fails
  String _errorMessage = '';
  
  /// Current user
  User? _user;
  
  /// User details from custom tables
  Map<String, dynamic>? _userDetails;

  /// Getters
  AuthState get authState => _authState;
  String get errorMessage => _errorMessage;
  User? get user => _user;
  Map<String, dynamic>? get userDetails => _userDetails;
  bool get isAuthenticated => _authState == AuthState.authenticated;
  
  /// Constructor
  AuthProvider() {
    _initializeAuth();
  }
  
  /// Initialize authentication and check current state
  Future<void> _initializeAuth() async {
    try {
      _authState = AuthState.loading;
      notifyListeners();
      
      await _supabaseService.initialize();
      
      // Check if user is already authenticated
      final currentUser = _supabaseService.currentUser;
      if (currentUser != null) {
        _user = currentUser;
        _authState = AuthState.authenticated;
      } else {
        _authState = AuthState.unauthenticated;
      }
    } catch (e) {
      _errorMessage = 'Failed to initialize authentication: ${e.toString()}';
      _authState = AuthState.error;
    } finally {
      notifyListeners();
    }
  }
  
  /// Sign in with school ID and password
  Future<bool> signInWithSchoolId(String schoolId, String password) async {
    try {
      _authState = AuthState.loading;
      _errorMessage = '';
      _userDetails = null;
      notifyListeners();
      
      final response = await _supabaseService.signInWithSchoolId(schoolId, password);
      _user = response.user;
      
      if (_user != null) {
        // Fetch user details from custom tables
        _userDetails = await _supabaseService.getUserDetails(_user!.id);
        _authState = AuthState.authenticated;
        notifyListeners();
        return true;
      } else {
        _authState = AuthState.unauthenticated;
        _errorMessage = 'Authentication failed';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _authState = AuthState.error;
      _errorMessage = e.toString();
      notifyListeners();
      return false;
    }
  }
  
  /// Sign out the current user
  Future<void> signOut() async {
    try {
      _authState = AuthState.loading;
      notifyListeners();
      
      await _supabaseService.signOut();
      
      _user = null;
      _authState = AuthState.unauthenticated;
    } catch (e) {
      _errorMessage = 'Sign out failed: ${e.toString()}';
      _authState = AuthState.error;
    } finally {
      notifyListeners();
    }
  }
  
  /// Reset password
  Future<bool> resetPassword(String email) async {
    try {
      await _supabaseService.resetPassword(email);
      return true;
    } catch (e) {
      _errorMessage = 'Password reset failed: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}
