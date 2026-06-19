# Qwen2.5-Coder 3B Model Testing - Task Batch 1

## Model: qwen2.5-coder:3b
## Testing Approach: Aider with 8 Firebase Integration Tasks
## Model Size: 3B Parameters (Better training than Phi4-Mini)

---

## Instructions for Testing

Run Aider with this command:
```bash
aider --model ollama/qwen2.5-coder:3b
```

Then ask the model to complete the following 8 tasks in order:

---

## Task 1: Add Firebase Dependencies

**Objective**: Add Firebase packages to pubspec.yaml

**Instructions**:
Add these packages to the `dependencies` section in `pubspec.yaml`:
```yaml
firebase_core: ^1.24.0
firebase_auth: ^4.20.0
cloud_firestore: ^4.13.0
firebase_storage: ^11.5.0
```

**Requirements**:
- ✅ Add all 4 packages with the specific versions shown
- ✅ Don't remove or break existing dependencies
- ✅ Keep YAML formatting correct (indentation)
- ✅ Verify file is valid YAML after changes

**Success Criteria**:
- pubspec.yaml has all 4 Firebase packages
- File is properly formatted
- No duplicate dependencies
- Existing dependencies (flutter, cupertino_icons, flutter_svg, video_player) are preserved

---

## Task 2: Create Firebase Service Class

**Objective**: Create a singleton Firebase service for initialization

**File**: `lib/services/firebase_service.dart`

**Requirements**:
- ✅ Initialize Firebase in a static method
- ✅ Handle initialization errors with try-catch
- ✅ Provide a static getInstance() method
- ✅ Add documentation comments
- ✅ Make it a singleton pattern

**Example structure**:
```dart
class FirebaseService {
  static FirebaseService? _instance;
  
  FirebaseService._();
  
  static FirebaseService getInstance() {
    _instance ??= FirebaseService._();
    return _instance;
  }
  
  static Future<void> initialize() {
    // Initialize Firebase
  }
}
```

**Success Criteria**:
- File created at lib/services/firebase_service.dart
- Singleton pattern correctly implemented
- Error handling present
- Code compiles without errors

---

## Task 3: Setup Firebase Authentication

**Objective**: Add auth methods to firebase_service.dart

**Add these methods**:
1. `registerWithEmail(String email, String password)` - Register new user
2. `loginWithEmail(String email, String password)` - Login existing user
3. `logout()` - Sign out user
4. `getCurrentUser()` - Get current user data

**Requirements**:
- ✅ Use FirebaseAuth from firebase_auth package
- ✅ Validate email and password inputs
- ✅ Handle exceptions (weak password, user exists, invalid email)
- ✅ Return user data or error messages
- ✅ Add try-catch for all auth operations

**Success Criteria**:
- All 4 methods implemented
- Proper error handling
- Uses FirebaseAuth correctly
- Code compiles

---

## Task 4: Create User Model

**Objective**: Create a User data model

**File**: `lib/models/user_model.dart`

**Fields Required**:
- `userId` (String) - Unique user identifier
- `email` (String) - User email
- `fullName` (String) - Full name
- `phoneNumber` (String) - Phone number
- `profilePictureUrl` (String) - Profile image URL
- `createdAt` (DateTime) - Account creation date

**Methods Required**:
- `toJson()` - Convert to JSON map
- `fromJson(Map<String, dynamic>)` - Create from JSON
- `toString()` - String representation
- `copyWith()` - Create modified copy

**Success Criteria**:
- All fields present
- Serialization methods work correctly
- No compilation errors
- Constructors are clear

---

## Task 5: Implement Firestore User Service

**Objective**: Create service for Firestore user operations

**File**: `lib/services/firestore_user_service.dart`

**Methods Required**:
1. `createUser(User user)` - Add user to Firestore
2. `getUser(String userId)` - Retrieve user by ID
3. `updateUser(User user)` - Update user profile
4. `deleteUser(String userId)` - Delete user
5. `getUserByEmail(String email)` - Find user by email

**Requirements**:
- ✅ Use FirebaseFirestore
- ✅ Collection name: 'users'
- ✅ Handle exceptions
- ✅ Return User objects
- ✅ Add error logging

**Success Criteria**:
- All 5 methods implemented
- Uses Firestore correctly
- Proper error handling
- Code compiles

---

## Task 6: Create Login Screen

**Objective**: Build a login UI screen

**File**: `lib/screens/auth/login_screen.dart`

**Required UI Elements**:
- Email text field
- Password text field with visibility toggle
- Login button
- Loading indicator (while authenticating)
- Error message display
- Registration link

**Functionality**:
- ✅ Validate email and password
- ✅ Call FirebaseService.loginWithEmail()
- ✅ Show loading state during auth
- ✅ Display error if login fails
- ✅ Navigate to home on success
- ✅ Navigate to registration screen on link tap

**Success Criteria**:
- Screen builds without errors
- All UI elements present
- Navigation logic works
- Form validation present

---

## Task 7: Create Registration Screen

**Objective**: Build a registration UI screen

**File**: `lib/screens/auth/register_screen.dart`

**Form Fields**:
- Full name text field
- Email text field
- Phone number field
- Password field (with strength indicator)
- Confirm password field
- Register button
- Login link

**Validation**:
- ✅ Email format validation
- ✅ Password strength check (min 8 chars, uppercase, numbers)
- ✅ Passwords match check
- ✅ Phone format validation
- ✅ All fields required

**Functionality**:
- ✅ Call FirebaseService.registerWithEmail()
- ✅ Create User model with form data
- ✅ Save user to Firestore
- ✅ Show loading state
- ✅ Display errors
- ✅ Navigate to login on success

**Success Criteria**:
- Screen builds without errors
- Form validation works
- Registration flow complete
- Error handling present

---

## Task 8: Create Profile Screen

**Objective**: Build a user profile display and edit screen

**File**: `lib/screens/profile/profile_screen.dart`

**Display Section**:
- Profile picture
- User name
- User email
- User phone
- Member since date
- Edit profile button
- Change password button
- Logout button

**Features**:
- ✅ Load user data from Firestore
- ✅ Display loading indicator while fetching
- ✅ Show error if data fails to load
- ✅ Edit profile opens dialog/sheet
- ✅ Logout shows confirmation dialog
- ✅ Logout clears user session

**Success Criteria**:
- Screen displays user info correctly
- Edit and logout buttons functional
- Loading states shown
- Error handling present

---

## Evaluation Rubric for Qwen 3B

Rate each task (1-10):

1. **Correctness** - Does it work? All requirements met?
2. **Code Quality** - Follows Dart/Flutter conventions?
3. **Completeness** - All features implemented?
4. **Error Handling** - Proper exceptions and validation?
5. **Performance** - Efficient code?

---

## Notes for Testing

- Qwen 3B should perform better than both DeepSeek 1.3B and Phi4-Mini
- Watch for actual file creation vs. just explanations
- Verify pubspec.yaml is correctly modified
- Check that no existing files are corrupted
- Use `git status` to verify actual changes made
