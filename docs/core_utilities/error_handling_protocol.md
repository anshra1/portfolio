# Error Handling Protocol

This document defines the standard error handling flow for the application. It ensures consistency, stability, and a better user experience by strictly separating low-level exceptions from domain failures.

---

## 1. Core Concepts

### **Exceptions (`AppException`)**
*   **Where:** Thrown in the **Data Layer** (Data Sources).
*   **Purpose:** Represents a technical failure (e.g., 404, No Internet, Disk Full).
*   **Location:** `lib/core/error/exception.dart`

### **Failures (`Failure`)**
*   **Where:** Returned by the **Domain Layer** (Repositories & Use Cases).
*   **Purpose:** Represents a business logic or user-facing failure.
*   **Location:** `lib/core/error/failure.dart`

---

## 2. The Workflow (Data Flow)

1.  **Data Source:** **THROWS** a specific `AppException`.
2.  **Repository:** **CATCHES** the `Exception`, **MAPS** it to a `Failure` using `ErrorMapper`, and **RETURNS** `Left(Failure)`.
3.  **Use Case:** Passes the `Either<Failure, T>` result to the BLoC.
4.  **BLoC:** Handles the `Failure` (Left) side and emits an error state.

---

## 3. Implementation Guide

### Step 1: Throwing Exceptions (Data Source)
**NEVER** throw raw Dart `Exception` or `Error`. Always use a concrete class extending `AppException`.

```dart
// lib/features/auth/data/datasources/auth_remote_data_source.dart

Future<UserModel> login(String email, String password) async {
  try {
    final response = await api.post('/login', data: {...});
    return UserModel.fromJson(response.data);
  } catch (e, stackTrace) {
    // 1. Wrap external errors in a specific AppException
    throw ServerException(
      methodName: 'login',
      originalError: e.toString(),
      stackTrace: stackTrace.toString(),
      userMessage: 'Unable to sign in. Please check your connection.',
      title: 'Login Failed',
      priority: ErrorPriority.high,
      context: {'email': email}, // Add context for analytics
    );
  }
}
```

### Step 2: Catching & Mapping (Repository)
Repositories act as the firewall. They must catch **ALL** exceptions and convert them to `Failure`.

```dart
// lib/features/auth/data/repositories/auth_repository_impl.dart

@override
ResultFuture<User> login(String email, String password) async {
  try {
    final userModel = await _dataSource.login(email, password);
    return Right(userModel.toEntity());
  } catch (e) {
    // 2. Use ErrorMapper to convert Exception -> Failure automatically
    return Left(ErrorMapper.mapErrorToFailure(e));
  }
}
```

### Step 3: Handling in UI (BLoC)
The BLoC receives the `Either<Failure, User>` and decides how to present it.

```dart
// lib/features/auth/presentation/bloc/auth_bloc.dart

Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  
  final result = await _loginUseCase(
    LoginParams(email: event.email, password: event.password),
  );

  result.fold(
    (failure) => emit(AuthError(
      message: failure.message,
      title: failure.title,
    )),
    (user) => emit(AuthAuthenticated(user: user)),
  );
}
```

---

## 4. Extending the System

If you encounter a scenario requiring a new error type:

1.  **Define Exception:** Create `MyNewException` in `lib/core/error/exception.dart` (extend `AppException`).
2.  **Define Failure:** Create `MyNewFailure` in `lib/core/error/failure.dart` (extend `Failure`).
3.  **Update Mapper:** Add a case to `ErrorMapper.mapErrorToFailure` in `lib/core/error/error_mapper.dart`.

---

## 5. Best Practices

*   **Context is King:** Always populate the `context` map in Exceptions with relevant IDs (orderId, userId) to aid debugging.
*   **User-Friendly Messages:** The `userMessage` field in an Exception should be ready for UI display. Do not put technical jargon there.
*   **Priorities:** Use `ErrorPriority` to distinguish between minor UI glitches and critical crashes.