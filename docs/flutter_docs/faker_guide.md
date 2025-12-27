# Faker Package Documentation (v2.2.0)

This document provides a detailed reference for using the `faker` package in Dart/Flutter. It covers installation, basic usage, and a comprehensive list of all available data providers and methods found in version 2.2.0.

## 1. Installation

Add the following to your `pubspec.yaml`:

```yaml
dependencies:
  faker: ^2.2.0
```

Then run:
```bash
dart pub get
# or
flutter pub get
```

## 2. Basic Usage

Import the package and instantiate the `Faker` class.

```dart
import 'package:faker/faker.dart';

void main() {
  final faker = Faker();

  print(faker.person.name());
  print(faker.internet.email());
}
```

## 3. Providers Reference

The `Faker` class exposes numerous "providers" (properties) for different categories of data.

### 3.1. Person (`faker.person`)
Generates names and personal details.
- `name()`: "Mrs. Fiona Ward MD" (Full name with optional prefix/suffix)
- `firstName()`: "Fiona"
- `lastName()`: "Ward"
- `prefix()`: "Mrs."
- `suffix()`: "MD"

### 3.2. Internet (`faker.internet`)
Generates web and network-related data.
- **Email**:
  - `email()`: "fiona_ward@yahoo.com"
  - `freeEmail()`: "fiona.ward@gmail.com" (gmail, yahoo, hotmail)
  - `safeEmail()`: "fiona-ward@example.com" (example.org, etc.)
  - `disposableEmail()`: "fiona_ward@mailinator.com"
- **Web**:
  - `userName()`: "fiona_ward"
  - `domainName()`: "ward.com"
  - `domainWord()`: "ward"
  - `uri(protocol)`: "ftp://ward.com"
  - `httpUrl()`: "http://ward.com"
  - `httpsUrl()`: "https://ward.com"
  - `userAgent({osName})`: "Mozilla/5.0..." (Optional OS filter like 'ios')
  - `password({length})`: "j8#jd@9s"
- **Network**:
  - `ipv4Address()`: "192.168.0.1"
  - `ipv6Address()`: "2001:0db8:85a3:0000:0000:8a2e:0370:7334"
  - `macAddress()`: "00:0a:95:9d:68:16"

### 3.3. Address (`faker.address`)
Generates location and address data.
- **Street**:
  - `streetName()`: "Ward St"
  - `streetAddress()`: "123 Ward St"
  - `streetSuffix()`: "St"
  - `buildingNumber()`: "123"
- **City/Area**:
  - `city()`: "New Fiona"
  - `cityPrefix()`: "New"
  - `citySuffix()`: "ville"
  - `neighborhood()`: "East Village"
  - `zipCode()`: "10001"
- **Region**:
  - `state()`: "California"
  - `stateAbbreviation()`: "CA"
  - `stateAsMap()`: `{'state': 'California', 'abbreviation': 'CA'}`
  - `country()`: "United States"
  - `countryCode()`: "US"
  - `continent()`: "North America"

### 3.4. Job (`faker.job`)
- `title()`: "Senior Software Engineer" (Combines prefix, adjective, and noun)

### 3.5. Company (`faker.company`)
- `name()`: "Ward Inc"
- `suffix()`: "Inc"
- `position()`: "Director"

### 3.6. Lorem (`faker.lorem`)
Generates placeholder text (Latin).
- `word()`: "dolor"
- `words(count)`: `['dolor', 'sit', 'amet']`
- `sentence()`: "Lorem ipsum dolor sit amet."
- `sentences(count)`: List of random sentences.

### 3.7. Image (`faker.image`)
Generates image URLs.
- `loremPicsum({width, height, seed, imageFormat})`: "https://picsum.photos/seed/abc/640/480.jpg"
  - `imageFormat` accepts `ImageFormat.jpg` or `ImageFormat.webp`.
- `image({width, height, keywords})`: Uses Unsplash/lorempixel (Deprecated)

### 3.8. Date (`faker.date`)
Generates `DateTime` objects and strings.
- `dateTime({minYear, maxYear})`: Random `DateTime`.
- `dateTimeBetween(start, end)`: Random `DateTime` between two dates.
- `year({minYear, maxYear})`: "2023" or "2023 AD"
- `month()`: "January"
- `time()`: "3:42 PM" or "23:52" (Randomly includes suffix/timezone)
- `justTime()`: "14:30" (HH:mm format)

### 3.9. Color (`faker.color`)
- `color()`: "Red"
- `commonColor()`: "Blue" (Smaller subset)
- `rgbColor({prefix, casing, format, includeAlpha})`: "#FF0000", "rgb(255, 0, 0)", "rgba(255, 0, 0, 0.5)"

### 3.10. Vehicle (`faker.vehicle`)
- `asVehicle()`: Returns a `VehicleYMM` object.
- `vehicle()`: Returns map `{'Year': 2020, 'Make': 'Tesla', 'Model': 'Model S'}`
- `make()`: "Tesla"
- `model()`: "Model S"
- `year()`: "2020"
- `yearMakeModel()`: "2020 Tesla Model S"
- `colorYearMakeModel()`: "Red 2020 Tesla Model S"
- `vin()`: Random Vehicle Identification Number.

### 3.11. PhoneNumber (`faker.phoneNumber`)
- `us()`: "555-0199" (US formats)
- `de()`: German formats
- `ja()`: Japanese formats

### 3.12. JWT (`faker.jwt`)
Generates JSON Web Tokens.
- `valid({expiresIn})`: A valid signed JWT.
- `expired({expiresIn})`: An expired signed JWT.
- `custom({expiresIn, payload})`: JWT with custom payload.

### 3.13. Other Providers
- **Animal**: `faker.animal.name()` ("Lion")
- **Conference**: `faker.conference.name()` ("Big Data 2023")
- **Currency**:
    - `code()`: "USD"
    - `name()`: "US Dollar"
- **Food**:
    - `dish()`: "Pizza"
    - `cuisine()`: "Italian"
    - `restaurant()`: "Pizza Hut"
- **Geo**:
    - `latitude()`: -90.0 to 90.0
    - `longitude()`: -180.0 to 180.0
- **Guid**: `faker.guid.guid()` (UUID-like string)
- **Sport**: `faker.sport.name()` ("Football")

## 4. Random Generator (`faker.randomGenerator`)

Access the underlying random utility for custom data generation.

```dart
// Numbers
faker.randomGenerator.integer(100, min: 10); // 10 to 99
faker.randomGenerator.decimal(scale: 5, min: 1); // Double between 1.0 and 6.0
faker.randomGenerator.boolean(); // true/false
faker.randomGenerator.numbers(10, 5); // List of 5 numbers up to 10
faker.randomGenerator.numberOfLength(10); // "4829104829" (String of digits)

// Strings & Collections
faker.randomGenerator.string(10); // Random string of length 10
faker.randomGenerator.element(['a', 'b', 'c']); // Random list item
faker.randomGenerator.mapElementKey({'a': 1, 'b': 2}); // 'a' or 'b'
faker.randomGenerator.mapElementValue({'a': 1, 'b': 2}); // 1 or 2
faker.randomGenerator.amount((_) => faker.internet.email(), 5); // List of 5 emails

// Patterns
faker.randomGenerator.fromPattern(['#####', '##-###']); // Replaces # with digits
faker.randomGenerator.fromCharSet('ABC', 5); // String from charset
```

## 5. Seeding (Deterministic Data)

To generate the same sequence of data every time (essential for stable unit tests), pass a seed to the constructor.

```dart
final faker = Faker.withGenerator(RandomGenerator(seed: 12345));
print(faker.person.name()); // Will always be the same for this seed
```

## 6. Localization

The package supports provider replacement for localization.
Example of using a custom Lorem provider:

```dart
class MyLoremProvider extends LoremDataProvider {
  @override
  List<String> sentencesList() => ['Hola mundo', 'Como estas'];
  @override
  List<String> wordsList() => ['hola', 'mundo'];
}

final faker = Faker.withGenerator(RandomGenerator(), provider: FakerDataProvider(loremDataProvider: MyLoremProvider()));
```

The package also includes a built-in Farsi (Persian) provider:
```dart
final faFaker = Faker(provider: FakerDataProviderFa());
print(faFaker.lorem.word()); // Returns a Farsi word
```

Note: Only `Lorem` currently has a dedicated accessible data provider interface (`LoremDataProvider`) in the main constructor. For other localizations, you may need to extend or implement custom logic.
