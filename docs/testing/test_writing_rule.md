# Test Writing Rule: Explicit Functional Typing

Always provide explicit type arguments for every element whenever possible for `dartz` helpers in tests.

### Required Syntax
```dart
right<Failure, Entity>(tEntity)
left<Failure, Entity>(tFailure)
```

### Prohibited Syntax
```dart
Right(tEntity)
Left(tFailure)
```