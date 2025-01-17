import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/features/people/enums/gender.dart';
import 'package:movies_app/features/people/models/person.dart';

import '../../../test-utils/dummy-data/dummy_configs.dart';

void main() {
  const Map<String, dynamic> rawExamplePerson = {
    'adult': false,
    'gender': 1,
    'id': 224513,
    'known_for': [],
    'known_for_department': 'Acting',
    'name': 'Ana de Armas',
    'popularity': 493.285,
    'profile_path': '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    'biography': null,
    'birthday': '1988-04-30',
    'deathday': '2001-04-30',
    'homepage': null,
    'imdb_id': null,
    'place_of_birth': null,
  };

  final Person examplePerson = Person(
    id: 224513,
    adult: false,
    gender: Gender.female,
    knownFor: const [],
    knownForDepartment: 'Acting',
    name: 'Ana de Armas',
    popularity: 493.285,
    profilePath: '/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg',
    birthday: DateTime(1988, 4, 30),
    deathDate: DateTime(2001, 4, 30),
    homepage: null,
    imdbId: null,
    placeOfBirth: null,
  );

  test('can parse data fromJson', () {
    expect(Person.fromJson(rawExamplePerson), equals(examplePerson));
  });

  test('can convert data toJson', () {
    expect(examplePerson.toJson(), equals(rawExamplePerson));
  });

  test('returns null dates for invalid formats', () {
    Map<String, dynamic> invalidDateExamplePerson = {
      ...rawExamplePerson,
      'deathday': 'invalid!',
      'birthday': 'invalid!',
    };

    expect(Person.fromJson(invalidDateExamplePerson).birthday, isNull);
    expect(Person.fromJson(invalidDateExamplePerson).deathDate, isNull);
  });

  test('can populate avatar and cover from profilePath with correct image urls',
      () {
    Person personWithGeneratedImages =
        examplePerson.populateImages(DummyConfigs.imageConfigs);

    String avatarUrl =
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Person.avatarSize.name}${examplePerson.profilePath}';
    // https://image.tmdb.org/t/p/h632/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(
      personWithGeneratedImages.avatar,
      equals(avatarUrl),
    );

    String coverUrl =
        '${DummyConfigs.imageConfigs.secureBaseUrl}${Person.coverSize.name}${examplePerson.profilePath}';
    // https://image.tmdb.org/t/p/original/14uxt0jH28J9zn4vNQNTae3Bmr7.jpg

    expect(
      personWithGeneratedImages.cover,
      equals(coverUrl),
    );
  });
}
