# Wash N Roll Project - AI Model Testing Tasks
## 32 Development Tasks for Model Evaluation

These tasks will be used to test and compare different Ollama models through Aider.
Each model will work on these tasks independently and results will be evaluated.

---

## Phase 1: Firebase Integration (Tasks 1-8)

### Task 1: Add Firebase Dependencies
Install and configure Firebase packages in pubspec.yaml:
- firebase_core
- firebase_auth
- cloud_firestore
- firebase_storage

### Task 2: Create Firebase Service Class
Create a new file `lib/services/firebase_service.dart` that:
- Initializes Firebase in the app
- Provides methods for Firebase operations
- Handles initialization errors gracefully

### Task 3: Setup Firebase Authentication
Implement user authentication with:
- Email/password registration
- Email/password login
- Logout functionality
- Error handling for invalid credentials

### Task 4: Create User Model
Create `lib/models/user_model.dart` with:
- User ID
- Email
- Full name
- Phone number
- Profile picture URL
- Serialization methods (toJson/fromJson)

### Task 5: Implement Firestore User Service
Create `lib/services/firestore_user_service.dart` with:
- Create user in Firestore
- Read user data
- Update user profile
- Delete user account

### Task 6: Add Authentication Screen
Create `lib/screens/auth/login_screen.dart` that:
- Has email and password fields
- Validates input
- Shows loading state
- Displays error messages
- Navigates to home on success

### Task 7: Add Registration Screen
Create `lib/screens/auth/register_screen.dart` that:
- Has email, password, name, phone fields
- Validates all inputs
- Checks password strength
- Shows loading state
- Handles registration errors

### Task 8: Add Profile Screen
Create `lib/screens/profile/profile_screen.dart` that:
- Displays user information
- Allows editing profile
- Shows logout button
- Has loading states

---

## Phase 2: Booking System (Tasks 9-16)

### Task 9: Create Booking Model
Create `lib/models/booking_model.dart` with:
- Booking ID
- User ID
- Service type
- Vehicle type
- Booking date/time
- Completion date/time
- Price
- Status (pending, completed, cancelled)
- Serialization methods

### Task 10: Create Service Model
Create `lib/models/service_model.dart` with:
- Service ID
- Service name (wash, detailing, polish, etc.)
- Description
- Base price
- Duration in minutes
- Image URL
- Serialization methods

### Task 11: Implement Firestore Booking Service
Create `lib/services/firestore_booking_service.dart` with:
- Create new booking
- Get user's bookings
- Get all bookings (admin)
- Update booking status
- Cancel booking
- Delete booking

### Task 12: Implement Firestore Service Catalog
Create `lib/services/firestore_service_catalog.dart` with:
- Get all available services
- Get service by ID
- Add service (admin)
- Update service (admin)
- Delete service (admin)

### Task 13: Create Booking List Screen
Create `lib/screens/bookings/booking_list_screen.dart` that:
- Displays user's bookings
- Shows booking status
- Allows filtering by status
- Pull-to-refresh functionality
- Shows empty state

### Task 14: Create Booking Detail Screen
Create `lib/screens/bookings/booking_detail_screen.dart` that:
- Shows full booking details
- Allows cancellation
- Shows service provider info
- Shows location/time
- Displays pricing breakdown

### Task 15: Create New Booking Screen
Create `lib/screens/bookings/new_booking_screen.dart` that:
- Displays available services
- Lets user select service
- Allows date/time selection
- Shows price calculation
- Confirms booking

### Task 16: Create Service Catalog Screen
Create `lib/screens/services/service_catalog_screen.dart` that:
- Displays all available services
- Shows service details
- Allows filtering/search
- Shows pricing
- Navigates to booking screen

---

## Phase 3: Vehicle Management (Tasks 17-20)

### Task 17: Create Vehicle Model
Create `lib/models/vehicle_model.dart` with:
- Vehicle ID
- User ID
- Vehicle type (car, SUV, truck, etc.)
- Make and model
- Color
- License plate
- Year
- Serialization methods

### Task 18: Implement Firestore Vehicle Service
Create `lib/services/firestore_vehicle_service.dart` with:
- Add vehicle
- Get user's vehicles
- Update vehicle
- Delete vehicle
- Get vehicle by ID

### Task 19: Create Vehicle Management Screen
Create `lib/screens/vehicles/vehicle_management_screen.dart` that:
- Lists user's vehicles
- Shows add vehicle button
- Allows editing vehicles
- Allows deleting vehicles
- Shows empty state

### Task 20: Create Add/Edit Vehicle Screen
Create `lib/screens/vehicles/add_edit_vehicle_screen.dart` that:
- Form for vehicle details
- Vehicle type selection
- Input validation
- Photo upload capability
- Success confirmation

---

## Phase 4: UI & Theme Improvements (Tasks 21-24)

### Task 21: Create Reusable Button Component
Create `lib/widgets/custom_button.dart` with:
- Customizable button styles
- Loading state support
- Disabled state
- Different button types (primary, secondary)

### Task 22: Create Reusable Text Input Component
Create `lib/widgets/custom_text_field.dart` with:
- Input validation support
- Error message display
- Password visibility toggle
- Icon support
- Custom theming

### Task 23: Create Loading Dialog
Create `lib/widgets/loading_dialog.dart` with:
- Centered loading indicator
- Dismissible option
- Custom message display

### Task 24: Implement Dark/Light Theme Toggle
Update `lib/theme/app_theme.dart` to:
- Support light and dark themes
- Add theme switching capability
- Persist theme preference
- Update all screens to use themes

---

## Phase 5: Error Handling & Validation (Tasks 25-28)

### Task 25: Create Error Handling Service
Create `lib/services/error_handler_service.dart` with:
- Parse Firebase errors
- User-friendly error messages
- Error logging
- Error recovery suggestions

### Task 26: Add Input Validation Utilities
Create `lib/utils/validators.dart` with:
- Email validation
- Password strength validation
- Phone number validation
- Date/time validation

### Task 27: Create Exception Classes
Create `lib/exceptions/custom_exceptions.dart` with:
- AuthenticationException
- FirestoreException
- ValidationException
- NetworkException

### Task 28: Add Global Error Dialog
Create `lib/widgets/error_dialog.dart` that:
- Displays error messages
- Shows error details
- Provides retry option
- Dismissible

---

## Phase 6: Advanced Features (Tasks 29-32)

### Task 29: Implement Search Functionality
Add search to relevant screens:
- Search services by name
- Search bookings by date or ID
- Search vehicles by type
- Debounce search queries

### Task 30: Add Payment Integration Setup
Create `lib/services/payment_service.dart` with:
- Stripe/PayPal payment interface
- Payment processing
- Transaction history
- Receipt generation

### Task 31: Create Dashboard/Home Screen
Create `lib/screens/home/home_screen.dart` that:
- Shows upcoming bookings
- Shows recent bookings
- Shows quick stats
- Navigation menu
- User greeting

### Task 32: Add Analytics and Logging
Implement logging throughout the app:
- User actions logging
- Error logging
- Performance monitoring
- Firebase Analytics integration

---

## Evaluation Criteria for Each Task

For each task, the AI model will be evaluated on:

1. **Code Quality**
   - Follows Dart/Flutter best practices
   - Proper error handling
   - Clear naming conventions
   - Comments where needed

2. **Completeness**
   - All requirements met
   - No incomplete implementations
   - Proper state management
   - Edge cases handled

3. **Functionality**
   - Code runs without errors
   - Feature works as specified
   - Proper integration with Firebase
   - UI is responsive

4. **Performance**
   - Efficient queries
   - Proper caching
   - No unnecessary rebuilds
   - Memory efficient

5. **Security**
   - Input validation
   - Secure data handling
   - Proper Firebase rules consideration
   - No hardcoded secrets

6. **UI/UX**
   - Clean, intuitive interface
   - Proper error messaging
   - Loading states shown
   - Consistent with design

---

## Testing Process

1. **Initial Git Commit**: Save baseline before model testing
2. **Model Testing**: Run Aider with each model
3. **Code Review**: Evaluate task completion
4. **Metrics Collection**:
   - Time taken per task
   - Number of iterations needed
   - Bugs/issues found
   - Code quality score
5. **Documentation**: Record findings
6. **Comparison**: Compare all models

---

## Notes for Models

When working on these tasks, follow these guidelines:

- Always read existing code before making changes
- Maintain consistency with existing code style
- Add proper error handling and validation
- Write clear comments for complex logic
- Test your code before declaring it done
- Ask for clarification if requirements are unclear
- Make incremental changes and verify after each change
