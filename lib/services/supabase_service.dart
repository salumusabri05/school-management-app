import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// SupabaseService - Handles all interactions with Supabase
class SupabaseService {
  /// Private singleton instance
  static final SupabaseService _instance = SupabaseService._internal();

  /// Singleton factory constructor
  factory SupabaseService() => _instance;

  /// Private constructor
  SupabaseService._internal();

  /// Supabase client instance
  late final SupabaseClient _client;

  /// Indicates if the service is initialized
  bool _initialized = false;

  /// Initialize Supabase - must be called before any other method
  Future<void> initialize() async {
    if (_initialized) return;

    // Replace with your Supabase URL and anon key
    const supabaseUrl = 'https://jqjfqofzdqyiicsfnugs.supabase.co';
    const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpxamZxb2Z6ZHF5aWljc2ZudWdzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTY4MDY1NDUsImV4cCI6MjA3MjM4MjU0NX0.EAYqn9kB7l6c9yUcPf5K6VhcYsjMeglgwJj87d3suwM';

    try {
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        debug: kDebugMode,
      );
      
      _client = Supabase.instance.client;
      _initialized = true;

      // Listen for auth state changes
      _client.auth.onAuthStateChange.listen(_handleAuthStateChange);
      
      debugPrint('✓ Supabase initialized successfully');
    } catch (error) {
      debugPrint('✗ Supabase initialization failed: $error');
      rethrow;
    }
  }

  /// Get the current user
  User? get currentUser => _client.auth.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => currentUser != null;

  /// Get the current auth session
  Session? get currentSession => _client.auth.currentSession;
  
  /// Get the Supabase client
  SupabaseClient get client {
    assert(_initialized, 'SupabaseService not initialized. Call initialize() first.');
    return _client;
  }

  /// Sign in with email and password
  Future<AuthResponse> signInWithEmailPassword(String email, String password) async {
    try {
      final response = await _client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      debugPrint('✗ Sign in error: $error');
      rethrow;
    }
  }

  /// Sign in with School ID (custom implementation)
  Future<AuthResponse> signInWithSchoolId(String schoolId, String password) async {
    try {
      // In real implementation, you might want to:
      // 1. Make a custom RPC call to validate school ID
      // 2. Then convert school ID to email format
      
      // For now, we'll assume school IDs are emails
      final email = '$schoolId@school.com';
      
      final response = await signInWithEmailPassword(email, password);
      return response;
    } catch (error) {
      debugPrint('✗ Sign in with school ID error: $error');
      rethrow;
    }
  }

  /// Sign up with email and password
  Future<AuthResponse> signUpWithEmailPassword(String email, String password) async {
    try {
      final response = await _client.auth.signUp(
        email: email,
        password: password,
      );
      return response;
    } catch (error) {
      debugPrint('✗ Sign up error: $error');
      rethrow;
    }
  }

  /// Sign out the current user
  Future<void> signOut() async {
    try {
      await _client.auth.signOut();
    } catch (error) {
      debugPrint('✗ Sign out error: $error');
      rethrow;
    }
  }

  /// Reset password
  Future<void> resetPassword(String email) async {
    try {
      await _client.auth.resetPasswordForEmail(email);
    } catch (error) {
      debugPrint('✗ Reset password error: $error');
      rethrow;
    }
  }

  /// Create a test user with full profile
  Future<User?> createTestUser({
    required String schoolId,
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    try {
      // Step 1: Sign up the user with Supabase Auth
      final authResponse = await _client.auth.signUp(
        email: email,
        password: password,
      );
      
      if (authResponse.user == null) {
        throw Exception('Failed to create user');
      }
      
      final user = authResponse.user!;
      final userId = user.id;
      
      // Step 2: Create entry in the users table
      await _client.from('users').insert({
        'id': userId,
        'email': email,
        'school_id': schoolId,
        'first_name': firstName,
        'last_name': lastName,
        'role': role,
      });
      
      // Step 3: Additional profile data based on role
      await _client.from('profiles').insert({
        'id': userId,
        'bio': 'Test user profile',
      });
      
      // Step 4: Role specific data
      if (role == 'student') {
        await _client.from('students').insert({
          'id': userId,
          'admission_number': schoolId,
          'grade_level': '10', // Default grade for test user
        });
      } else if (role == 'teacher') {
        await _client.from('teachers').insert({
          'id': userId,
          'employee_id': schoolId,
          'subjects': ['Mathematics', 'Science'], // Default subjects for test
        });
      }
      
      debugPrint('✓ Test user created successfully: $schoolId ($role)');
      return user;
    } catch (error) {
      debugPrint('✗ Create test user error: $error');
      rethrow;
    }
  }
  
  /// Add a test admin user (convenience method for initial setup)
  Future<User?> addTestAdminUser() async {
    return createTestUser(
      schoolId: 'ADMIN001',
      email: 'admin@school.com',
      password: 'password123',
      firstName: 'Admin',
      lastName: 'User',
      role: 'admin',
    );
  }
  
  /// Add a test teacher user (convenience method for initial setup)
  Future<User?> addTestTeacherUser() async {
    return createTestUser(
      schoolId: 'TEACHER001',
      email: 'teacher@school.com',
      password: 'password123',
      firstName: 'Teacher',
      lastName: 'User',
      role: 'teacher',
    );
  }
  
  /// Add a test student user (convenience method for initial setup)
  Future<User?> addTestStudentUser() async {
    return createTestUser(
      schoolId: 'STUDENT001',
      email: 'student@school.com',
      password: 'password123',
      firstName: 'Student',
      lastName: 'User',
      role: 'student',
    );
  }

  /// Get user details from custom tables after authentication
  Future<Map<String, dynamic>?> getUserDetails(String userId) async {
    try {
      // Get basic user info
      final userResponse = await _client
          .from('users')
          .select('*')
          .eq('id', userId)
          .maybeSingle();
      
      if (userResponse == null) {
        return null;
      }
      
      // Get profile data
      final profileResponse = await _client
          .from('profiles')
          .select('*')
          .eq('id', userId)
          .maybeSingle();
      
      // Combine data
      final Map<String, dynamic> userDetails = {
        ...userResponse,
        'profile': profileResponse ?? <String, dynamic>{},
      };
      
      // Add role-specific data
      final role = userResponse['role'] as String;
      if (role == 'student') {
        final studentData = await _client
            .from('students')
            .select('*')
            .eq('id', userId)
            .single();
        userDetails['role_data'] = studentData;
      } else if (role == 'teacher') {
        final teacherData = await _client
            .from('teachers')
            .select('*')
            .eq('id', userId)
            .single();
        userDetails['role_data'] = teacherData;
      }
      
      return userDetails;
    } catch (error) {
      debugPrint('✗ Get user details error: $error');
      return null;
    }
  }

  /// Handle auth state changes
  void _handleAuthStateChange(AuthState state) {
    final session = state.session;
    final event = state.event;
    
    debugPrint('Auth state changed: $event');
    
    switch (event) {
      case AuthChangeEvent.signedIn:
        debugPrint('User signed in: ${session?.user.email}');
        break;
      case AuthChangeEvent.signedOut:
        debugPrint('User signed out');
        break;
      case AuthChangeEvent.tokenRefreshed:
        debugPrint('Token refreshed');
        break;
      case AuthChangeEvent.userUpdated:
        debugPrint('User updated');
        break;
      case AuthChangeEvent.passwordRecovery:
        debugPrint('Password recovery initiated');
        break;
      default:
        debugPrint('Unhandled auth event: $event');
    }
  }
}
