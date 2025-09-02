import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screens/home_page.dart';
import 'screens/onboarding_page.dart';
import 'screens/login_page.dart';
import 'providers/auth_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/role_selection_page.dart';
import 'screens/admin/admin_dashboard_page.dart';
import 'screens/student/student_dashboard_page.dart';
import 'screens/teacher/teacher_dashboard_page.dart';
import 'screens/parent/parent_dashboard_page.dart';
import 'screens/admin/reports/reports_page.dart';
import 'screens/admin/reports/reports_performance_page.dart';
import 'screens/admin/reports/reports_attendance_page.dart';

/// Entry point for the application
void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations (portrait only for now)
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Run the app with Provider for state management
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MainApp(),
    ),
  );
}

/// MainApp widget - Root of the application
/// Sets up the theme and routing configuration
class MainApp extends StatelessWidget {
  /// Default constructor
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hide debug banner
      title: "ShuleApp",
      theme: ThemeData(
        // Define the color scheme using blue, green and purple
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF4A55A2), // Blue color
          secondary: const Color(0xFF7895CB), // Light blue color
          tertiary: const Color(0xFF9376E0), // Purple color
          background: Colors.white,
        ),
        useMaterial3: true,
        // Define text theme for consistency
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontWeight: FontWeight.bold),
          bodyLarge: TextStyle(fontSize: 16.0),
        ),
        // Button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
      // Define application routes
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(), // Start with splash screen
        "/onboarding": (context) => const OnboardingPage(),
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/role_selection": (context) => const RoleSelectionPage(),
        "/admin_dashboard": (context) => const AdminDashboardPage(),
        "/teacher_dashboard": (context) => const TeacherDashboardPage(),
        "/student_dashboard": (context) => const StudentDashboardPage(),
        "/parent_dashboard": (context) => const ParentDashboardPage(),
        // Reports section routes
        "/admin/reports": (context) => const ReportsPage(),
        "/admin/reports/performance": (context) => const ReportsPerformancePage(),
        "/admin/reports/attendance": (context) => const ReportsAttendancePage(),
      },
      // Handle unknown routes
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: const Center(child: Text('Page not found!')),
          ),
        );
      },
    );
  }
}
