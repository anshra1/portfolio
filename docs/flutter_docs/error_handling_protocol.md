# AI Error Handling Protocol

This document defines the mandatory procedure for AI agents when writing or modifying code in this project. 

## 1. Mandatory Exception Usage
**Never throw generic exceptions.**
* **Forbidden:** `throw Exception('message');`, `throw 'Error';`, `throw Error();`
* **Mandatory:** Use the specialized classes defined in `lib/core/error/exception.dart`.

## 2. The "Stop & Expand" Workflow
If you encounter a scenario that requires a specific error type (e.g., `PaymentDeclined`, `AuthExpired`) and a corresponding class does not exist in `lib/core/error/exception.dart`:

1. **STOP** your current implementation task.
2. **CREATE** the new Exception class in `lib/core/error/exception.dart` by extending `AppException`.
3. **CREATE** the corresponding Failure class in `lib/core/error/failure.dart` by extending `Failure`.
4. **UPDATE** the `ErrorMapper` in `lib/core/error/error_mapper.dart` to handle the new mapping.
5. **VERIFY** that you've added an appropriate default `priority` and `isRecoverable` status.
6. **RESUME** your original task using the newly created classes.

## 3. Scale-Ready Requirements
When throwing an exception, follow these rules for a "Million-User" production environment:

### A. Error Codes (The `code` property)
* **Optional but Recommended:** If you don't provide a `code`, the system will generate one (e.g., `SERVER_EXCEPTION`).
* **When to use:** Use specific codes for errors that support teams need to identify quickly (e.g., `PAY-402` for payment required).

### B. Structured Context (The `context` property)
* **Mandatory for Complex Errors:** Never put variable data inside the `userMessage` or `originalError` strings.
* **Format:** Use the `context` Map to store key-value pairs for analytics (Firebase/Sentry).
* **Example:**
  ```dart
  throw ServerException(
    methodName: 'processPayment',
    originalError: error.toString(),
    userMessage: 'Payment failed. Please try again.',
    title: 'Payment Error',
    context: {
      'order_id': order.id,
      'retry_count': attempt,
    },
  );
  ```

## 4. UI Layer Rule
* Always map Exceptions to Failures using `ErrorMapper.mapErrorToFailure(e)` before passing them to the UI layer (Bloc/Cubit/Provider).
* The UI should display the `userMessage` and `title` from the `Failure`.
