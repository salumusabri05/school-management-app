import 'package:flutter/material.dart';
import '../services/supabase_service.dart';

/// TestUserScreen - A utility screen to add test users
/// This screen should NOT be included in production builds
class TestUserScreen extends StatefulWidget {
  /// Default constructor
  const TestUserScreen({super.key});

  @override
  State<TestUserScreen> createState() => _TestUserScreenState();
}

class _TestUserScreenState extends State<TestUserScreen> {
  final SupabaseService _supabaseService = SupabaseService();
  bool _isLoading = false;
  String _statusMessage = '';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test User Management'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            const Text(
              'Add Test Users',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            
            const SizedBox(height: 8),
            
            const Text(
              'Use these buttons to add pre-configured test users for development purposes.',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Admin user button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _addAdminUser,
              icon: const Icon(Icons.admin_panel_settings),
              label: const Text('Add Test Admin User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Teacher user button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _addTeacherUser,
              icon: const Icon(Icons.person),
              label: const Text('Add Test Teacher User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.secondary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Student user button
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _addStudentUser,
              icon: const Icon(Icons.school),
              label: const Text('Add Test Student User'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.tertiary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            
            const SizedBox(height: 24),
            
            // Status section
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
              
            if (_statusMessage.isNotEmpty)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _statusMessage.contains('Error') 
                      ? Colors.red.withOpacity(0.1)
                      : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _statusMessage,
                  style: TextStyle(
                    color: _statusMessage.contains('Error') 
                        ? Colors.red
                        : Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              
            const SizedBox(height: 32),
            
            // User credentials section
            if (!_isLoading && _statusMessage.contains('Success'))
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Login Credentials:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text('Admin: ADMIN001 / password123'),
                      Text('Teacher: TEACHER001 / password123'),
                      Text('Student: STUDENT001 / password123'),
                      SizedBox(height: 8),
                      Text('Note: Use the School ID as the login identifier.'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  // Add admin user
  Future<void> _addAdminUser() async {
    await _addUser('admin');
  }
  
  // Add teacher user
  Future<void> _addTeacherUser() async {
    await _addUser('teacher');
  }
  
  // Add student user
  Future<void> _addStudentUser() async {
    await _addUser('student');
  }
  
  // Generic method to add a user
  Future<void> _addUser(String role) async {
    if (_isLoading) return;
    
    setState(() {
      _isLoading = true;
      _statusMessage = '';
    });
    
    try {
      switch (role) {
        case 'admin':
          await _supabaseService.addTestAdminUser();
          break;
        case 'teacher':
          await _supabaseService.addTestTeacherUser();
          break;
        case 'student':
          await _supabaseService.addTestStudentUser();
          break;
        default:
          throw Exception('Invalid role');
      }
      
      setState(() {
        _statusMessage = 'Success! $role user has been added.';
      });
    } catch (e) {
      setState(() {
        _statusMessage = 'Error: ${e.toString()}';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
