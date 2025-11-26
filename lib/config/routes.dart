import 'package:go_router/go_router.dart';
import 'package:study_organizer/screens/auth/login_screen.dart';
import 'package:study_organizer/screens/auth/register_screen.dart';
import 'package:study_organizer/screens/auth/otp_verification_screen.dart';
import 'package:study_organizer/screens/auth/forgot_password_screen.dart';
import 'package:study_organizer/screens/home/home_screen.dart';
import 'package:study_organizer/screens/subjects/subjects_screen.dart';
import 'package:study_organizer/screens/subjects/subject_detail_screen.dart';
import 'package:study_organizer/screens/tasks/tasks_screen.dart';
import 'package:study_organizer/screens/files/files_screen.dart';
import 'package:study_organizer/screens/stats/stats_screen.dart';
import 'package:study_organizer/screens/settings/settings_screen.dart';
import 'package:study_organizer/screens/support/support_screen.dart';
import 'package:study_organizer/screens/admin/admin_dashboard_screen.dart';

class AppRoutes {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/otp-verification',
        builder: (context, state) => const OTPVerificationScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      
      // Main Routes
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/subjects',
        builder: (context, state) => const SubjectsScreen(),
      ),
      GoRoute(
        path: '/subject/:id',
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return SubjectDetailScreen(subjectId: id);
        },
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => const TasksScreen(),
      ),
      GoRoute(
        path: '/files',
        builder: (context, state) => const FilesScreen(),
      ),
      GoRoute(
        path: '/stats',
        builder: (context, state) => const StatsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/support',
        builder: (context, state) => const SupportScreen(),
      ),
      
      // Admin Routes
      GoRoute(
        path: '/admin',
        builder: (context, state) => const AdminDashboardScreen(),
      ),
    ],
  );
}
