# DeepSeek 1.3B Model Testing - Task Batch 1

## Model: deepseek-coder:1.3b
## Testing Approach: Aider with 8 Firebase Integration Tasks

---

## Instructions for Testing

Run Aider with this command:
```bash
aider --model ollama/deepseek-coder:1.3b --read-only-rules "Check before modifying pubspec.yaml"
```

Then ask the model to complete the following 8 tasks in order:

---

## Task 1: Add Firebase Dependencies

Add these packages to `pubspec.yaml`:
```yaml
dependencies:
  firebase_core
  firebase_auth
  cloud_firestore
  firebase_storage
```

Requirements:
- Add all 4 packages
- Pin to stable versions
- Don't break existing dependencies
- Keep the file properly formatted

---

## Task 2: Create Firebase Service Class

Create file: `lib/services/firebase_service.dart`

Requirements:
- Initialize Firebase in the app
- Handle initialization errors
- Provide a singleton instance
- Include proper documentation

---

## Task 3: Setup Firebase Authentication

Implement in `lib/services/firebase_service.dart`:
- Email/password registration with validation
- Email/password login with error handling
- Logout functionality
- Return user data on successful auth

---

## Task 4: Create User Model

Create file: `lib/models/user_model.dart`

Fields:
- userId (String)
- email (String)
- fullName (String)
- phoneNumber (String)
- profilePictureUrl (String)
- createdAt (DateTime)

Methods:
- toJson() - serialize to JSON
- fromJson() - deserialize from JSON
- toString() - for debugging

---

## Task 5: Implement Firestore User Service

Create file: `lib/services/firestore_user_service.dart`

Methods:
- createUser(User user) - add new user to Firestore
- getUser(String userId) - retrieve user from Firestore
- updateUser(User user) - update user profile
- deleteUser(String userId) - delete user from Firestore
- getUserByEmail(String email) - find user by email

---

## Task 6: Add Authentication Screen

Create file: `lib/screens/auth/login_screen.dart`

Features:
- Email input field
- Password input field (with visibility toggle)
- Login button
- Loading state while authenticating
- Error message display
- Navigation to home on success
- Link to registration screen

---

## Task 7: Add Registration Screen

Create file: `lib/screens/auth/register_screen.dart`

Fields:
- Email input
- Password input (with strength indicator)
- Confirm password
- Full name
- Phone number

Features:
- Validate all inputs
- Check password strength (minimum 8 chars, mixed case, numbers)
- Show errors clearly
- Loading state
- Navigate to login on success

---

## Task 8: Add Profile Screen

Create file: `lib/screens/profile/profile_screen.dart`

Features:
- Display user name, email, phone
- Edit profile button
- Change password option
- Logout button
- Loading states
- Confirmation dialogs

---

## Evaluation Metrics

For each task, evaluate:

1. **Completion**: Does it fulfill all requirements?
2. **Code Quality**: Follows Dart/Flutter best practices?
3. **Error Handling**: Proper exception handling?
4. **Testing Readiness**: Can the code be compiled/tested?
5. **Time Taken**: How long for model to complete?
6. **Iterations Needed**: How many back-and-forth exchanges?

---

## Notes

- The model has full access to the project
- It can read existing files to maintain consistency
- It should follow existing code patterns
- Document any issues or incomplete implementations
