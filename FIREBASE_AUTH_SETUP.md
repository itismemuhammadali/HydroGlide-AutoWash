# Firebase Authentication Setup for Wash N Roll

## Overview

This document outlines the complete Firebase authentication backend implementation for the Wash N Roll app with role-based access control (Customer, Employee, Admin).

## Completed Implementation

### 1. Backend Services

#### Firebase Service (`lib/services/firebase_service.dart`)
- Singleton pattern for Firebase Authentication
- Enhanced with `firebase_core` import
- Methods:
  - `initialize()` - Initializes Firebase
  - `registerWithEmail()` - Creates new user account
  - `loginWithEmail()` - Signs in existing user
  - `logout()` - Signs out current user
  - `getCurrentUser()` - Returns currently signed-in user

#### Firestore User Service (`lib/services/firestore_user_service.dart`)
- Manages user data in Firestore
- Methods:
  - `createUser()` - Creates new user document
  - `getUserById()` - Retrieves user by ID
  - `getUserByEmail()` - Retrieves user by email
  - `updateUser()` - Updates user information
  - `deleteUser()` - Deletes user document
  - `emailExists()` - Checks if email is registered
  - `getUsersByRole()` - Gets all users with specific role
  - `getUserStream()` - Real-time user data updates
  - `updateUserProfile()` - Updates profile information

#### User Model (`lib/models/user_model.dart`)
- `UserModel` class with fields:
  - `id` - Unique user identifier (Firebase UID)
  - `email` - User email
  - `name` - Display name
  - `phone` - Contact number (optional)
  - `profileImageUrl` - Profile picture URL (optional)
  - `role` - User role (customer/employee/admin)
  - `createdAt` - Account creation timestamp
  - `updatedAt` - Last update timestamp
  - `isActive` - Account status flag

- `UserRole` enum with values:
  - `customer` - Regular customer
  - `employee` - Service employee
  - `admin` - Administrator

- Helper methods:
  - `toJson()` - Convert to Firestore format
  - `fromJson()` - Create from Firestore document
  - `copyWith()` - Create modified copy

### 2. State Management (Riverpod)

#### Customer Auth Provider (`lib/providers/customer_auth_provider.dart`)
- `AuthState` class containing:
  - `firebaseUser` - Firebase User object
  - `appUser` - UserModel object
  - `isLoading` - Loading indicator
  - `errorMessage` - Error message

- `CustomerAuthNotifier` with methods:
  - `signUp()` - Register new customer with validation
  - `signIn()` - Sign in existing customer
  - `signOut()` - Sign out current user
  - `clearError()` - Clear error messages

- Riverpod Providers:
  - `firebaseServiceProvider` - Firebase Service instance
  - `firestoreUserServiceProvider` - Firestore User Service instance
  - `customerAuthProvider` - Main auth state provider
  - `isAuthenticatedProvider` - Check authentication status
  - `currentUserProvider` - Get current user data
  - `authErrorProvider` - Get current error message
  - `isAuthLoadingProvider` - Check if operation is loading

### 3. Authentication Handler

#### Auth Handler (`lib/services/auth_handler.dart`)
- Singleton for Firebase initialization
- Centralizes Firebase setup process
- Handles initialization errors gracefully

### 4. Firestore Security Rules (`firestore.rules`)

Complete role-based access control rules:

**Users Collection:**
- Users can read/write their own profile
- Admins can read all profiles
- Users can only sign up as customers
- Users cannot change their role

**Bookings Collection (future use):**
- Customers can create and read their own bookings
- Employees can read assigned bookings
- Admins can read/write all bookings

**Services Collection (future use):**
- All authenticated users can read services
- Only admins can manage services

**Reviews Collection (future use):**
- All users can read reviews
- Customers can create reviews for their bookings
- Admins can delete reviews

**Admin Logs Collection (audit trail):**
- Only admins can read/write logs

### 5. Frontend Integration

#### Main App (`lib/main.dart`)
- Wrapped with Riverpod `ProviderScope`
- Enables state management across app

#### Splash Screen (`lib/screens/splash/splash_screen.dart`)
- Initializes Firebase on app startup
- No UI changes to layout

#### Login Screen (`lib/screens/auth/login_screen.dart`)
- Integrated `customerAuthProvider` for sign-in
- Input validation (email, password required)
- Error handling with SnackBar
- No UI layout changes

#### Signup Screen (`lib/screens/auth/customer/signup_screen.dart`)
- Integrated `customerAuthProvider` for sign-up
- Form validation:
  - All fields required
  - Password confirmation check
  - Minimum 6-character password
- Email uniqueness check
- Error handling with SnackBar
- No UI layout changes

## Dependencies Added

```yaml
firebase_core: ^1.24.0
firebase_auth: ^4.20.0
cloud_firestore: ^4.13.0
firebase_storage: ^11.5.0
flutter_riverpod: ^2.4.0
```

## Configuration Steps

### 1. Firebase Console Setup
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Create new project or select existing
3. Enable Authentication:
   - Go to Authentication > Sign-in method
   - Enable Email/Password provider
4. Create Firestore database:
   - Start in production mode
   - Apply security rules from `firestore.rules`
5. Copy Firebase config and add to app

### 2. Flutter Configuration
1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

### 3. Deploy Security Rules
1. Install Firebase CLI:
   ```bash
   npm install -g firebase-tools
   ```

2. Login to Firebase:
   ```bash
   firebase login
   ```

3. Deploy rules:
   ```bash
   firebase deploy --only firestore:rules
   ```

## Authentication Flow

### Sign Up Flow
1. User enters username, email, phone, password
2. Form validation checks
3. Call `signUp()` method
4. Firebase creates account
5. Firestore document created with user data
6. User redirected to login screen
7. Success message shown

### Sign In Flow
1. User enters email and password
2. Input validation checks
3. Call `signIn()` method
4. Firebase authenticates credentials
5. Firestore retrieves user profile
6. Verify user role is "customer"
7. Check account is active
8. User redirected to app shell
9. Error message shown on failure

### Sign Out Flow
1. User initiates logout
2. Firebase session terminated
3. User data cleared from state
4. User redirected to onboarding

## Error Handling

The system handles various error scenarios:
- Weak password
- Email already in use
- Invalid email format
- User not found
- Wrong password
- Account deactivated
- Role mismatch
- Network errors

Errors are displayed to users via SnackBar notifications.

## Role-Based Features (Future Implementation)

### Customer
- Create bookings
- Track booking status
- Submit reviews
- View service details
- Manage profile

### Employee
- View assigned bookings
- Update booking status
- View customer information
- Submit work reports

### Admin
- Manage users (create, update, delete)
- Create and manage services
- View all bookings
- Generate reports
- Manage employee assignments
- View audit logs

## Testing

### Test Account
Create test accounts in Firebase Console for each role:
- Customer: customer@test.com
- Employee: employee@test.com
- Admin: admin@test.com

### Manual Testing Steps
1. Sign up as new customer
2. Sign in with created account
3. Verify user data in Firestore
4. Sign out
5. Sign in again to verify persistence

## Security Considerations

✓ Passwords encrypted via Firebase Auth
✓ Role-based access control enforced
✓ User can only modify own profile
✓ Email uniqueness enforced
✓ Account status can be managed
✓ Audit logging for admins
✓ Real-time synchronization via listeners
✓ Error messages don't leak sensitive info

## Future Enhancements

1. **Multi-factor Authentication (MFA)**
   - SMS or email verification
   - TOTP support

2. **Social Authentication**
   - Google Sign-In
   - Apple Sign-In

3. **Password Management**
   - Password reset via email
   - Password change functionality

4. **User Permissions**
   - Fine-grained permission system
   - Custom claims for complex roles

5. **Activity Logging**
   - Track user actions
   - Generate audit reports

6. **Session Management**
   - Device management
   - Session timeout
   - Sign out from other devices

## Git Commits

- **548364a**: Backend services foundation
- **2e4290a**: Frontend integration with providers

## Support

For issues or questions:
1. Check Firebase documentation
2. Review Firestore security rules
3. Enable Firebase debugging
4. Check app logs for errors
