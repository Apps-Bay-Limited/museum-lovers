// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Art _$ArtFromJson(Map<String, dynamic> json) {
  return _Art.fromJson(json);
}

/// @nodoc
class _$ArtTearOff {
  const _$ArtTearOff();

  _Art call(
      {required String id,
      required String objectNumber,
      required String title,
      required String longTitle,
      required String principalOrFirstMaker,
      required bool hasImage,
      required bool showImage,
      required ArtImage? webImage,
      required ArtImage? headerImage,
      required ArtLinks links}) {
    return _Art(
      id: id,
      objectNumber: objectNumber,
      title: title,
      longTitle: longTitle,
      principalOrFirstMaker: principalOrFirstMaker,
      hasImage: hasImage,
      showImage: showImage,
      webImage: webImage,
      headerImage: headerImage,
      links: links,
    );
  }

  Art fromJson(Map<String, Object?> json) {
    return Art.fromJson(json);
  }
}

/// @nodoc
const $Art = _$ArtTearOff();

/// @nodoc
mixin _$Art {
  String get id => throw _privateConstructorUsedError;
  String get objectNumber => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get longTitle => throw _privateConstructorUsedError;
  String get principalOrFirstMaker => throw _privateConstructorUsedError;
  bool get hasImage => throw _privateConstructorUsedError;
  bool get showImage => throw _privateConstructorUsedError;
  ArtImage? get webImage => throw _privateConstructorUsedError;
  ArtImage? get headerImage => throw _privateConstructorUsedError;
  ArtLinks get links => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtCopyWith<Art> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtCopyWith<$Res> {
  factory $ArtCopyWith(Art value, $Res Function(Art) then) =
      _$ArtCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String objectNumber,
      String title,
      String longTitle,
      String principalOrFirstMaker,
      bool hasImage,
      bool showImage,
      ArtImage? webImage,
      ArtImage? headerImage,
      ArtLinks links});

  $ArtImageCopyWith<$Res>? get webImage;
  $ArtImageCopyWith<$Res>? get headerImage;
  $ArtLinksCopyWith<$Res> get links;
}

/// @nodoc
class _$ArtCopyWithImpl<$Res> implements $ArtCopyWith<$Res> {
  _$ArtCopyWithImpl(this._value, this._then);

  final Art _value;
  // ignore: unused_field
  final $Res Function(Art) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? objectNumber = freezed,
    Object? title = freezed,
    Object? longTitle = freezed,
    Object? principalOrFirstMaker = freezed,
    Object? hasImage = freezed,
    Object? showImage = freezed,
    Object? webImage = freezed,
    Object? headerImage = freezed,
    Object? links = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      longTitle: longTitle == freezed
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: principalOrFirstMaker == freezed
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      hasImage: hasImage == freezed
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: showImage == freezed
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      webImage: webImage == freezed
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      headerImage: headerImage == freezed
          ? _value.headerImage
          : headerImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ArtLinks,
    ));
  }

  @override
  $ArtImageCopyWith<$Res>? get webImage {
    if (_value.webImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.webImage!, (value) {
      return _then(_value.copyWith(webImage: value));
    });
  }

  @override
  $ArtImageCopyWith<$Res>? get headerImage {
    if (_value.headerImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.headerImage!, (value) {
      return _then(_value.copyWith(headerImage: value));
    });
  }

  @override
  $ArtLinksCopyWith<$Res> get links {
    return $ArtLinksCopyWith<$Res>(_value.links, (value) {
      return _then(_value.copyWith(links: value));
    });
  }
}

/// @nodoc
abstract class _$ArtCopyWith<$Res> implements $ArtCopyWith<$Res> {
  factory _$ArtCopyWith(_Art value, $Res Function(_Art) then) =
      __$ArtCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String objectNumber,
      String title,
      String longTitle,
      String principalOrFirstMaker,
      bool hasImage,
      bool showImage,
      ArtImage? webImage,
      ArtImage? headerImage,
      ArtLinks links});

  @override
  $ArtImageCopyWith<$Res>? get webImage;
  @override
  $ArtImageCopyWith<$Res>? get headerImage;
  @override
  $ArtLinksCopyWith<$Res> get links;
}

/// @nodoc
class __$ArtCopyWithImpl<$Res> extends _$ArtCopyWithImpl<$Res>
    implements _$ArtCopyWith<$Res> {
  __$ArtCopyWithImpl(_Art _value, $Res Function(_Art) _then)
      : super(_value, (v) => _then(v as _Art));

  @override
  _Art get _value => super._value as _Art;

  @override
  $Res call({
    Object? id = freezed,
    Object? objectNumber = freezed,
    Object? title = freezed,
    Object? longTitle = freezed,
    Object? principalOrFirstMaker = freezed,
    Object? hasImage = freezed,
    Object? showImage = freezed,
    Object? webImage = freezed,
    Object? headerImage = freezed,
    Object? links = freezed,
  }) {
    return _then(_Art(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      longTitle: longTitle == freezed
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: principalOrFirstMaker == freezed
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      hasImage: hasImage == freezed
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: showImage == freezed
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      webImage: webImage == freezed
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      headerImage: headerImage == freezed
          ? _value.headerImage
          : headerImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      links: links == freezed
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ArtLinks,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Art implements _Art {
  const _$_Art(
      {required this.id,
      required this.objectNumber,
      required this.title,
      required this.longTitle,
      required this.principalOrFirstMaker,
      required this.hasImage,
      required this.showImage,
      required this.webImage,
      required this.headerImage,
      required this.links});

  factory _$_Art.fromJson(Map<String, dynamic> json) => _$$_ArtFromJson(json);

  @override
  final String id;
  @override
  final String objectNumber;
  @override
  final String title;
  @override
  final String longTitle;
  @override
  final String principalOrFirstMaker;
  @override
  final bool hasImage;
  @override
  final bool showImage;
  @override
  final ArtImage? webImage;
  @override
  final ArtImage? headerImage;
  @override
  final ArtLinks links;

  @override
  String toString() {
    return 'Art(id: $id, objectNumber: $objectNumber, title: $title, longTitle: $longTitle, principalOrFirstMaker: $principalOrFirstMaker, hasImage: $hasImage, showImage: $showImage, webImage: $webImage, headerImage: $headerImage, links: $links)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Art &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.objectNumber, objectNumber) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.longTitle, longTitle) &&
            const DeepCollectionEquality()
                .equals(other.principalOrFirstMaker, principalOrFirstMaker) &&
            const DeepCollectionEquality().equals(other.hasImage, hasImage) &&
            const DeepCollectionEquality().equals(other.showImage, showImage) &&
            const DeepCollectionEquality().equals(other.webImage, webImage) &&
            const DeepCollectionEquality()
                .equals(other.headerImage, headerImage) &&
            const DeepCollectionEquality().equals(other.links, links));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(objectNumber),
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(longTitle),
      const DeepCollectionEquality().hash(principalOrFirstMaker),
      const DeepCollectionEquality().hash(hasImage),
      const DeepCollectionEquality().hash(showImage),
      const DeepCollectionEquality().hash(webImage),
      const DeepCollectionEquality().hash(headerImage),
      const DeepCollectionEquality().hash(links));

  @JsonKey(ignore: true)
  @override
  _$ArtCopyWith<_Art> get copyWith =>
      __$ArtCopyWithImpl<_Art>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtToJson(this);
  }
}

abstract class _Art implements Art {
  const factory _Art(
      {required String id,
      required String objectNumber,
      required String title,
      required String longTitle,
      required String principalOrFirstMaker,
      required bool hasImage,
      required bool showImage,
      required ArtImage? webImage,
      required ArtImage? headerImage,
      required ArtLinks links}) = _$_Art;

  factory _Art.fromJson(Map<String, dynamic> json) = _$_Art.fromJson;

  @override
  String get id;
  @override
  String get objectNumber;
  @override
  String get title;
  @override
  String get longTitle;
  @override
  String get principalOrFirstMaker;
  @override
  bool get hasImage;
  @override
  bool get showImage;
  @override
  ArtImage? get webImage;
  @override
  ArtImage? get headerImage;
  @override
  ArtLinks get links;
  @override
  @JsonKey(ignore: true)
  _$ArtCopyWith<_Art> get copyWith => throw _privateConstructorUsedError;
}

ArtDetail _$ArtDetailFromJson(Map<String, dynamic> json) {
  return _ArtDetail.fromJson(json);
}

/// @nodoc
class _$ArtDetailTearOff {
  const _$ArtDetailTearOff();

  _ArtDetail call(
      {required String id,
      required String objectNumber,
      required List<ArtColor> colors,
      required List<ArtColor> normalizedColors,
      required String title,
      required List<String> titles,
      required String longTitle,
      required String subTitle,
      required String scLabelLine,
      required ArtLabel label,
      String? description,
      required List<String> objectTypes,
      required List<String> objectCollection,
      required String principalMaker,
      required String principalOrFirstMaker,
      required List<ArtMaker> principalMakers,
      String? plaqueDescriptionEnglish,
      required List<String> materials,
      required List<String> productionPlaces,
      required List<String> techniques,
      required List<String> physicalProperties,
      required bool hasImage,
      required bool showImage,
      required List<String> historicalPersons,
      required List<String> documentation,
      required List<ArtDimension> dimensions,
      String? physicalMedium,
      ArtImage? webImage,
      required ArtDating dating}) {
    return _ArtDetail(
      id: id,
      objectNumber: objectNumber,
      colors: colors,
      normalizedColors: normalizedColors,
      title: title,
      titles: titles,
      longTitle: longTitle,
      subTitle: subTitle,
      scLabelLine: scLabelLine,
      label: label,
      description: description,
      objectTypes: objectTypes,
      objectCollection: objectCollection,
      principalMaker: principalMaker,
      principalOrFirstMaker: principalOrFirstMaker,
      principalMakers: principalMakers,
      plaqueDescriptionEnglish: plaqueDescriptionEnglish,
      materials: materials,
      productionPlaces: productionPlaces,
      techniques: techniques,
      physicalProperties: physicalProperties,
      hasImage: hasImage,
      showImage: showImage,
      historicalPersons: historicalPersons,
      documentation: documentation,
      dimensions: dimensions,
      physicalMedium: physicalMedium,
      webImage: webImage,
      dating: dating,
    );
  }

  ArtDetail fromJson(Map<String, Object?> json) {
    return ArtDetail.fromJson(json);
  }
}

/// @nodoc
const $ArtDetail = _$ArtDetailTearOff();

/// @nodoc
mixin _$ArtDetail {
  String get id => throw _privateConstructorUsedError;
  String get objectNumber => throw _privateConstructorUsedError;
  List<ArtColor> get colors => throw _privateConstructorUsedError;
  List<ArtColor> get normalizedColors => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  List<String> get titles => throw _privateConstructorUsedError;
  String get longTitle => throw _privateConstructorUsedError;
  String get subTitle => throw _privateConstructorUsedError;
  String get scLabelLine => throw _privateConstructorUsedError;
  ArtLabel get label => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<String> get objectTypes => throw _privateConstructorUsedError;
  List<String> get objectCollection => throw _privateConstructorUsedError;
  String get principalMaker => throw _privateConstructorUsedError;
  String get principalOrFirstMaker => throw _privateConstructorUsedError;
  List<ArtMaker> get principalMakers => throw _privateConstructorUsedError;
  String? get plaqueDescriptionEnglish => throw _privateConstructorUsedError;
  List<String> get materials => throw _privateConstructorUsedError;
  List<String> get productionPlaces => throw _privateConstructorUsedError;
  List<String> get techniques => throw _privateConstructorUsedError;
  List<String> get physicalProperties => throw _privateConstructorUsedError;
  bool get hasImage => throw _privateConstructorUsedError;
  bool get showImage => throw _privateConstructorUsedError;
  List<String> get historicalPersons => throw _privateConstructorUsedError;
  List<String> get documentation => throw _privateConstructorUsedError;
  List<ArtDimension> get dimensions => throw _privateConstructorUsedError;
  String? get physicalMedium => throw _privateConstructorUsedError;
  ArtImage? get webImage => throw _privateConstructorUsedError;
  ArtDating get dating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtDetailCopyWith<ArtDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDetailCopyWith<$Res> {
  factory $ArtDetailCopyWith(ArtDetail value, $Res Function(ArtDetail) then) =
      _$ArtDetailCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String objectNumber,
      List<ArtColor> colors,
      List<ArtColor> normalizedColors,
      String title,
      List<String> titles,
      String longTitle,
      String subTitle,
      String scLabelLine,
      ArtLabel label,
      String? description,
      List<String> objectTypes,
      List<String> objectCollection,
      String principalMaker,
      String principalOrFirstMaker,
      List<ArtMaker> principalMakers,
      String? plaqueDescriptionEnglish,
      List<String> materials,
      List<String> productionPlaces,
      List<String> techniques,
      List<String> physicalProperties,
      bool hasImage,
      bool showImage,
      List<String> historicalPersons,
      List<String> documentation,
      List<ArtDimension> dimensions,
      String? physicalMedium,
      ArtImage? webImage,
      ArtDating dating});

  $ArtLabelCopyWith<$Res> get label;
  $ArtImageCopyWith<$Res>? get webImage;
  $ArtDatingCopyWith<$Res> get dating;
}

/// @nodoc
class _$ArtDetailCopyWithImpl<$Res> implements $ArtDetailCopyWith<$Res> {
  _$ArtDetailCopyWithImpl(this._value, this._then);

  final ArtDetail _value;
  // ignore: unused_field
  final $Res Function(ArtDetail) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? objectNumber = freezed,
    Object? colors = freezed,
    Object? normalizedColors = freezed,
    Object? title = freezed,
    Object? titles = freezed,
    Object? longTitle = freezed,
    Object? subTitle = freezed,
    Object? scLabelLine = freezed,
    Object? label = freezed,
    Object? description = freezed,
    Object? objectTypes = freezed,
    Object? objectCollection = freezed,
    Object? principalMaker = freezed,
    Object? principalOrFirstMaker = freezed,
    Object? principalMakers = freezed,
    Object? plaqueDescriptionEnglish = freezed,
    Object? materials = freezed,
    Object? productionPlaces = freezed,
    Object? techniques = freezed,
    Object? physicalProperties = freezed,
    Object? hasImage = freezed,
    Object? showImage = freezed,
    Object? historicalPersons = freezed,
    Object? documentation = freezed,
    Object? dimensions = freezed,
    Object? physicalMedium = freezed,
    Object? webImage = freezed,
    Object? dating = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      colors: colors == freezed
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      normalizedColors: normalizedColors == freezed
          ? _value.normalizedColors
          : normalizedColors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titles: titles == freezed
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longTitle: longTitle == freezed
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: subTitle == freezed
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      scLabelLine: scLabelLine == freezed
          ? _value.scLabelLine
          : scLabelLine // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as ArtLabel,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      objectTypes: objectTypes == freezed
          ? _value.objectTypes
          : objectTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      objectCollection: objectCollection == freezed
          ? _value.objectCollection
          : objectCollection // ignore: cast_nullable_to_non_nullable
              as List<String>,
      principalMaker: principalMaker == freezed
          ? _value.principalMaker
          : principalMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: principalOrFirstMaker == freezed
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalMakers: principalMakers == freezed
          ? _value.principalMakers
          : principalMakers // ignore: cast_nullable_to_non_nullable
              as List<ArtMaker>,
      plaqueDescriptionEnglish: plaqueDescriptionEnglish == freezed
          ? _value.plaqueDescriptionEnglish
          : plaqueDescriptionEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionPlaces: productionPlaces == freezed
          ? _value.productionPlaces
          : productionPlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: techniques == freezed
          ? _value.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      physicalProperties: physicalProperties == freezed
          ? _value.physicalProperties
          : physicalProperties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasImage: hasImage == freezed
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: showImage == freezed
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      historicalPersons: historicalPersons == freezed
          ? _value.historicalPersons
          : historicalPersons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: documentation == freezed
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dimensions: dimensions == freezed
          ? _value.dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as List<ArtDimension>,
      physicalMedium: physicalMedium == freezed
          ? _value.physicalMedium
          : physicalMedium // ignore: cast_nullable_to_non_nullable
              as String?,
      webImage: webImage == freezed
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      dating: dating == freezed
          ? _value.dating
          : dating // ignore: cast_nullable_to_non_nullable
              as ArtDating,
    ));
  }

  @override
  $ArtLabelCopyWith<$Res> get label {
    return $ArtLabelCopyWith<$Res>(_value.label, (value) {
      return _then(_value.copyWith(label: value));
    });
  }

  @override
  $ArtImageCopyWith<$Res>? get webImage {
    if (_value.webImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.webImage!, (value) {
      return _then(_value.copyWith(webImage: value));
    });
  }

  @override
  $ArtDatingCopyWith<$Res> get dating {
    return $ArtDatingCopyWith<$Res>(_value.dating, (value) {
      return _then(_value.copyWith(dating: value));
    });
  }
}

/// @nodoc
abstract class _$ArtDetailCopyWith<$Res> implements $ArtDetailCopyWith<$Res> {
  factory _$ArtDetailCopyWith(
          _ArtDetail value, $Res Function(_ArtDetail) then) =
      __$ArtDetailCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String objectNumber,
      List<ArtColor> colors,
      List<ArtColor> normalizedColors,
      String title,
      List<String> titles,
      String longTitle,
      String subTitle,
      String scLabelLine,
      ArtLabel label,
      String? description,
      List<String> objectTypes,
      List<String> objectCollection,
      String principalMaker,
      String principalOrFirstMaker,
      List<ArtMaker> principalMakers,
      String? plaqueDescriptionEnglish,
      List<String> materials,
      List<String> productionPlaces,
      List<String> techniques,
      List<String> physicalProperties,
      bool hasImage,
      bool showImage,
      List<String> historicalPersons,
      List<String> documentation,
      List<ArtDimension> dimensions,
      String? physicalMedium,
      ArtImage? webImage,
      ArtDating dating});

  @override
  $ArtLabelCopyWith<$Res> get label;
  @override
  $ArtImageCopyWith<$Res>? get webImage;
  @override
  $ArtDatingCopyWith<$Res> get dating;
}

/// @nodoc
class __$ArtDetailCopyWithImpl<$Res> extends _$ArtDetailCopyWithImpl<$Res>
    implements _$ArtDetailCopyWith<$Res> {
  __$ArtDetailCopyWithImpl(_ArtDetail _value, $Res Function(_ArtDetail) _then)
      : super(_value, (v) => _then(v as _ArtDetail));

  @override
  _ArtDetail get _value => super._value as _ArtDetail;

  @override
  $Res call({
    Object? id = freezed,
    Object? objectNumber = freezed,
    Object? colors = freezed,
    Object? normalizedColors = freezed,
    Object? title = freezed,
    Object? titles = freezed,
    Object? longTitle = freezed,
    Object? subTitle = freezed,
    Object? scLabelLine = freezed,
    Object? label = freezed,
    Object? description = freezed,
    Object? objectTypes = freezed,
    Object? objectCollection = freezed,
    Object? principalMaker = freezed,
    Object? principalOrFirstMaker = freezed,
    Object? principalMakers = freezed,
    Object? plaqueDescriptionEnglish = freezed,
    Object? materials = freezed,
    Object? productionPlaces = freezed,
    Object? techniques = freezed,
    Object? physicalProperties = freezed,
    Object? hasImage = freezed,
    Object? showImage = freezed,
    Object? historicalPersons = freezed,
    Object? documentation = freezed,
    Object? dimensions = freezed,
    Object? physicalMedium = freezed,
    Object? webImage = freezed,
    Object? dating = freezed,
  }) {
    return _then(_ArtDetail(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: objectNumber == freezed
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      colors: colors == freezed
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      normalizedColors: normalizedColors == freezed
          ? _value.normalizedColors
          : normalizedColors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titles: titles == freezed
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longTitle: longTitle == freezed
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: subTitle == freezed
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      scLabelLine: scLabelLine == freezed
          ? _value.scLabelLine
          : scLabelLine // ignore: cast_nullable_to_non_nullable
              as String,
      label: label == freezed
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as ArtLabel,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      objectTypes: objectTypes == freezed
          ? _value.objectTypes
          : objectTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      objectCollection: objectCollection == freezed
          ? _value.objectCollection
          : objectCollection // ignore: cast_nullable_to_non_nullable
              as List<String>,
      principalMaker: principalMaker == freezed
          ? _value.principalMaker
          : principalMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: principalOrFirstMaker == freezed
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalMakers: principalMakers == freezed
          ? _value.principalMakers
          : principalMakers // ignore: cast_nullable_to_non_nullable
              as List<ArtMaker>,
      plaqueDescriptionEnglish: plaqueDescriptionEnglish == freezed
          ? _value.plaqueDescriptionEnglish
          : plaqueDescriptionEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: materials == freezed
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionPlaces: productionPlaces == freezed
          ? _value.productionPlaces
          : productionPlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: techniques == freezed
          ? _value.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      physicalProperties: physicalProperties == freezed
          ? _value.physicalProperties
          : physicalProperties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasImage: hasImage == freezed
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: showImage == freezed
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      historicalPersons: historicalPersons == freezed
          ? _value.historicalPersons
          : historicalPersons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: documentation == freezed
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dimensions: dimensions == freezed
          ? _value.dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as List<ArtDimension>,
      physicalMedium: physicalMedium == freezed
          ? _value.physicalMedium
          : physicalMedium // ignore: cast_nullable_to_non_nullable
              as String?,
      webImage: webImage == freezed
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      dating: dating == freezed
          ? _value.dating
          : dating // ignore: cast_nullable_to_non_nullable
              as ArtDating,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtDetail implements _ArtDetail {
  const _$_ArtDetail(
      {required this.id,
      required this.objectNumber,
      required this.colors,
      required this.normalizedColors,
      required this.title,
      required this.titles,
      required this.longTitle,
      required this.subTitle,
      required this.scLabelLine,
      required this.label,
      this.description,
      required this.objectTypes,
      required this.objectCollection,
      required this.principalMaker,
      required this.principalOrFirstMaker,
      required this.principalMakers,
      this.plaqueDescriptionEnglish,
      required this.materials,
      required this.productionPlaces,
      required this.techniques,
      required this.physicalProperties,
      required this.hasImage,
      required this.showImage,
      required this.historicalPersons,
      required this.documentation,
      required this.dimensions,
      this.physicalMedium,
      this.webImage,
      required this.dating});

  factory _$_ArtDetail.fromJson(Map<String, dynamic> json) =>
      _$$_ArtDetailFromJson(json);

  @override
  final String id;
  @override
  final String objectNumber;
  @override
  final List<ArtColor> colors;
  @override
  final List<ArtColor> normalizedColors;
  @override
  final String title;
  @override
  final List<String> titles;
  @override
  final String longTitle;
  @override
  final String subTitle;
  @override
  final String scLabelLine;
  @override
  final ArtLabel label;
  @override
  final String? description;
  @override
  final List<String> objectTypes;
  @override
  final List<String> objectCollection;
  @override
  final String principalMaker;
  @override
  final String principalOrFirstMaker;
  @override
  final List<ArtMaker> principalMakers;
  @override
  final String? plaqueDescriptionEnglish;
  @override
  final List<String> materials;
  @override
  final List<String> productionPlaces;
  @override
  final List<String> techniques;
  @override
  final List<String> physicalProperties;
  @override
  final bool hasImage;
  @override
  final bool showImage;
  @override
  final List<String> historicalPersons;
  @override
  final List<String> documentation;
  @override
  final List<ArtDimension> dimensions;
  @override
  final String? physicalMedium;
  @override
  final ArtImage? webImage;
  @override
  final ArtDating dating;

  @override
  String toString() {
    return 'ArtDetail(id: $id, objectNumber: $objectNumber, colors: $colors, normalizedColors: $normalizedColors, title: $title, titles: $titles, longTitle: $longTitle, subTitle: $subTitle, scLabelLine: $scLabelLine, label: $label, description: $description, objectTypes: $objectTypes, objectCollection: $objectCollection, principalMaker: $principalMaker, principalOrFirstMaker: $principalOrFirstMaker, principalMakers: $principalMakers, plaqueDescriptionEnglish: $plaqueDescriptionEnglish, materials: $materials, productionPlaces: $productionPlaces, techniques: $techniques, physicalProperties: $physicalProperties, hasImage: $hasImage, showImage: $showImage, historicalPersons: $historicalPersons, documentation: $documentation, dimensions: $dimensions, physicalMedium: $physicalMedium, webImage: $webImage, dating: $dating)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtDetail &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality()
                .equals(other.objectNumber, objectNumber) &&
            const DeepCollectionEquality().equals(other.colors, colors) &&
            const DeepCollectionEquality()
                .equals(other.normalizedColors, normalizedColors) &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.titles, titles) &&
            const DeepCollectionEquality().equals(other.longTitle, longTitle) &&
            const DeepCollectionEquality().equals(other.subTitle, subTitle) &&
            const DeepCollectionEquality()
                .equals(other.scLabelLine, scLabelLine) &&
            const DeepCollectionEquality().equals(other.label, label) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality()
                .equals(other.objectTypes, objectTypes) &&
            const DeepCollectionEquality()
                .equals(other.objectCollection, objectCollection) &&
            const DeepCollectionEquality()
                .equals(other.principalMaker, principalMaker) &&
            const DeepCollectionEquality()
                .equals(other.principalOrFirstMaker, principalOrFirstMaker) &&
            const DeepCollectionEquality()
                .equals(other.principalMakers, principalMakers) &&
            const DeepCollectionEquality().equals(
                other.plaqueDescriptionEnglish, plaqueDescriptionEnglish) &&
            const DeepCollectionEquality().equals(other.materials, materials) &&
            const DeepCollectionEquality()
                .equals(other.productionPlaces, productionPlaces) &&
            const DeepCollectionEquality()
                .equals(other.techniques, techniques) &&
            const DeepCollectionEquality()
                .equals(other.physicalProperties, physicalProperties) &&
            const DeepCollectionEquality().equals(other.hasImage, hasImage) &&
            const DeepCollectionEquality().equals(other.showImage, showImage) &&
            const DeepCollectionEquality()
                .equals(other.historicalPersons, historicalPersons) &&
            const DeepCollectionEquality()
                .equals(other.documentation, documentation) &&
            const DeepCollectionEquality()
                .equals(other.dimensions, dimensions) &&
            const DeepCollectionEquality()
                .equals(other.physicalMedium, physicalMedium) &&
            const DeepCollectionEquality().equals(other.webImage, webImage) &&
            const DeepCollectionEquality().equals(other.dating, dating));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(id),
        const DeepCollectionEquality().hash(objectNumber),
        const DeepCollectionEquality().hash(colors),
        const DeepCollectionEquality().hash(normalizedColors),
        const DeepCollectionEquality().hash(title),
        const DeepCollectionEquality().hash(titles),
        const DeepCollectionEquality().hash(longTitle),
        const DeepCollectionEquality().hash(subTitle),
        const DeepCollectionEquality().hash(scLabelLine),
        const DeepCollectionEquality().hash(label),
        const DeepCollectionEquality().hash(description),
        const DeepCollectionEquality().hash(objectTypes),
        const DeepCollectionEquality().hash(objectCollection),
        const DeepCollectionEquality().hash(principalMaker),
        const DeepCollectionEquality().hash(principalOrFirstMaker),
        const DeepCollectionEquality().hash(principalMakers),
        const DeepCollectionEquality().hash(plaqueDescriptionEnglish),
        const DeepCollectionEquality().hash(materials),
        const DeepCollectionEquality().hash(productionPlaces),
        const DeepCollectionEquality().hash(techniques),
        const DeepCollectionEquality().hash(physicalProperties),
        const DeepCollectionEquality().hash(hasImage),
        const DeepCollectionEquality().hash(showImage),
        const DeepCollectionEquality().hash(historicalPersons),
        const DeepCollectionEquality().hash(documentation),
        const DeepCollectionEquality().hash(dimensions),
        const DeepCollectionEquality().hash(physicalMedium),
        const DeepCollectionEquality().hash(webImage),
        const DeepCollectionEquality().hash(dating)
      ]);

  @JsonKey(ignore: true)
  @override
  _$ArtDetailCopyWith<_ArtDetail> get copyWith =>
      __$ArtDetailCopyWithImpl<_ArtDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtDetailToJson(this);
  }
}

abstract class _ArtDetail implements ArtDetail {
  const factory _ArtDetail(
      {required String id,
      required String objectNumber,
      required List<ArtColor> colors,
      required List<ArtColor> normalizedColors,
      required String title,
      required List<String> titles,
      required String longTitle,
      required String subTitle,
      required String scLabelLine,
      required ArtLabel label,
      String? description,
      required List<String> objectTypes,
      required List<String> objectCollection,
      required String principalMaker,
      required String principalOrFirstMaker,
      required List<ArtMaker> principalMakers,
      String? plaqueDescriptionEnglish,
      required List<String> materials,
      required List<String> productionPlaces,
      required List<String> techniques,
      required List<String> physicalProperties,
      required bool hasImage,
      required bool showImage,
      required List<String> historicalPersons,
      required List<String> documentation,
      required List<ArtDimension> dimensions,
      String? physicalMedium,
      ArtImage? webImage,
      required ArtDating dating}) = _$_ArtDetail;

  factory _ArtDetail.fromJson(Map<String, dynamic> json) =
      _$_ArtDetail.fromJson;

  @override
  String get id;
  @override
  String get objectNumber;
  @override
  List<ArtColor> get colors;
  @override
  List<ArtColor> get normalizedColors;
  @override
  String get title;
  @override
  List<String> get titles;
  @override
  String get longTitle;
  @override
  String get subTitle;
  @override
  String get scLabelLine;
  @override
  ArtLabel get label;
  @override
  String? get description;
  @override
  List<String> get objectTypes;
  @override
  List<String> get objectCollection;
  @override
  String get principalMaker;
  @override
  String get principalOrFirstMaker;
  @override
  List<ArtMaker> get principalMakers;
  @override
  String? get plaqueDescriptionEnglish;
  @override
  List<String> get materials;
  @override
  List<String> get productionPlaces;
  @override
  List<String> get techniques;
  @override
  List<String> get physicalProperties;
  @override
  bool get hasImage;
  @override
  bool get showImage;
  @override
  List<String> get historicalPersons;
  @override
  List<String> get documentation;
  @override
  List<ArtDimension> get dimensions;
  @override
  String? get physicalMedium;
  @override
  ArtImage? get webImage;
  @override
  ArtDating get dating;
  @override
  @JsonKey(ignore: true)
  _$ArtDetailCopyWith<_ArtDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtColor _$ArtColorFromJson(Map<String, dynamic> json) {
  return _ArtColor.fromJson(json);
}

/// @nodoc
class _$ArtColorTearOff {
  const _$ArtColorTearOff();

  _ArtColor call({required double percentage, required String hex}) {
    return _ArtColor(
      percentage: percentage,
      hex: hex,
    );
  }

  ArtColor fromJson(Map<String, Object?> json) {
    return ArtColor.fromJson(json);
  }
}

/// @nodoc
const $ArtColor = _$ArtColorTearOff();

/// @nodoc
mixin _$ArtColor {
  double get percentage => throw _privateConstructorUsedError;
  String get hex => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtColorCopyWith<ArtColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtColorCopyWith<$Res> {
  factory $ArtColorCopyWith(ArtColor value, $Res Function(ArtColor) then) =
      _$ArtColorCopyWithImpl<$Res>;
  $Res call({double percentage, String hex});
}

/// @nodoc
class _$ArtColorCopyWithImpl<$Res> implements $ArtColorCopyWith<$Res> {
  _$ArtColorCopyWithImpl(this._value, this._then);

  final ArtColor _value;
  // ignore: unused_field
  final $Res Function(ArtColor) _then;

  @override
  $Res call({
    Object? percentage = freezed,
    Object? hex = freezed,
  }) {
    return _then(_value.copyWith(
      percentage: percentage == freezed
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      hex: hex == freezed
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ArtColorCopyWith<$Res> implements $ArtColorCopyWith<$Res> {
  factory _$ArtColorCopyWith(_ArtColor value, $Res Function(_ArtColor) then) =
      __$ArtColorCopyWithImpl<$Res>;
  @override
  $Res call({double percentage, String hex});
}

/// @nodoc
class __$ArtColorCopyWithImpl<$Res> extends _$ArtColorCopyWithImpl<$Res>
    implements _$ArtColorCopyWith<$Res> {
  __$ArtColorCopyWithImpl(_ArtColor _value, $Res Function(_ArtColor) _then)
      : super(_value, (v) => _then(v as _ArtColor));

  @override
  _ArtColor get _value => super._value as _ArtColor;

  @override
  $Res call({
    Object? percentage = freezed,
    Object? hex = freezed,
  }) {
    return _then(_ArtColor(
      percentage: percentage == freezed
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      hex: hex == freezed
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtColor implements _ArtColor {
  const _$_ArtColor({required this.percentage, required this.hex});

  factory _$_ArtColor.fromJson(Map<String, dynamic> json) =>
      _$$_ArtColorFromJson(json);

  @override
  final double percentage;
  @override
  final String hex;

  @override
  String toString() {
    return 'ArtColor(percentage: $percentage, hex: $hex)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtColor &&
            const DeepCollectionEquality()
                .equals(other.percentage, percentage) &&
            const DeepCollectionEquality().equals(other.hex, hex));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(percentage),
      const DeepCollectionEquality().hash(hex));

  @JsonKey(ignore: true)
  @override
  _$ArtColorCopyWith<_ArtColor> get copyWith =>
      __$ArtColorCopyWithImpl<_ArtColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtColorToJson(this);
  }
}

abstract class _ArtColor implements ArtColor {
  const factory _ArtColor({required double percentage, required String hex}) =
      _$_ArtColor;

  factory _ArtColor.fromJson(Map<String, dynamic> json) = _$_ArtColor.fromJson;

  @override
  double get percentage;
  @override
  String get hex;
  @override
  @JsonKey(ignore: true)
  _$ArtColorCopyWith<_ArtColor> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDating _$ArtDatingFromJson(Map<String, dynamic> json) {
  return _ArtDating.fromJson(json);
}

/// @nodoc
class _$ArtDatingTearOff {
  const _$ArtDatingTearOff();

  _ArtDating call(
      {required String presentingDate,
      required int sortingDate,
      required int period,
      required int yearEarly,
      required int yearLate}) {
    return _ArtDating(
      presentingDate: presentingDate,
      sortingDate: sortingDate,
      period: period,
      yearEarly: yearEarly,
      yearLate: yearLate,
    );
  }

  ArtDating fromJson(Map<String, Object?> json) {
    return ArtDating.fromJson(json);
  }
}

/// @nodoc
const $ArtDating = _$ArtDatingTearOff();

/// @nodoc
mixin _$ArtDating {
  String get presentingDate => throw _privateConstructorUsedError;
  int get sortingDate => throw _privateConstructorUsedError;
  int get period => throw _privateConstructorUsedError;
  int get yearEarly => throw _privateConstructorUsedError;
  int get yearLate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtDatingCopyWith<ArtDating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDatingCopyWith<$Res> {
  factory $ArtDatingCopyWith(ArtDating value, $Res Function(ArtDating) then) =
      _$ArtDatingCopyWithImpl<$Res>;
  $Res call(
      {String presentingDate,
      int sortingDate,
      int period,
      int yearEarly,
      int yearLate});
}

/// @nodoc
class _$ArtDatingCopyWithImpl<$Res> implements $ArtDatingCopyWith<$Res> {
  _$ArtDatingCopyWithImpl(this._value, this._then);

  final ArtDating _value;
  // ignore: unused_field
  final $Res Function(ArtDating) _then;

  @override
  $Res call({
    Object? presentingDate = freezed,
    Object? sortingDate = freezed,
    Object? period = freezed,
    Object? yearEarly = freezed,
    Object? yearLate = freezed,
  }) {
    return _then(_value.copyWith(
      presentingDate: presentingDate == freezed
          ? _value.presentingDate
          : presentingDate // ignore: cast_nullable_to_non_nullable
              as String,
      sortingDate: sortingDate == freezed
          ? _value.sortingDate
          : sortingDate // ignore: cast_nullable_to_non_nullable
              as int,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      yearEarly: yearEarly == freezed
          ? _value.yearEarly
          : yearEarly // ignore: cast_nullable_to_non_nullable
              as int,
      yearLate: yearLate == freezed
          ? _value.yearLate
          : yearLate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
abstract class _$ArtDatingCopyWith<$Res> implements $ArtDatingCopyWith<$Res> {
  factory _$ArtDatingCopyWith(
          _ArtDating value, $Res Function(_ArtDating) then) =
      __$ArtDatingCopyWithImpl<$Res>;
  @override
  $Res call(
      {String presentingDate,
      int sortingDate,
      int period,
      int yearEarly,
      int yearLate});
}

/// @nodoc
class __$ArtDatingCopyWithImpl<$Res> extends _$ArtDatingCopyWithImpl<$Res>
    implements _$ArtDatingCopyWith<$Res> {
  __$ArtDatingCopyWithImpl(_ArtDating _value, $Res Function(_ArtDating) _then)
      : super(_value, (v) => _then(v as _ArtDating));

  @override
  _ArtDating get _value => super._value as _ArtDating;

  @override
  $Res call({
    Object? presentingDate = freezed,
    Object? sortingDate = freezed,
    Object? period = freezed,
    Object? yearEarly = freezed,
    Object? yearLate = freezed,
  }) {
    return _then(_ArtDating(
      presentingDate: presentingDate == freezed
          ? _value.presentingDate
          : presentingDate // ignore: cast_nullable_to_non_nullable
              as String,
      sortingDate: sortingDate == freezed
          ? _value.sortingDate
          : sortingDate // ignore: cast_nullable_to_non_nullable
              as int,
      period: period == freezed
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      yearEarly: yearEarly == freezed
          ? _value.yearEarly
          : yearEarly // ignore: cast_nullable_to_non_nullable
              as int,
      yearLate: yearLate == freezed
          ? _value.yearLate
          : yearLate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtDating implements _ArtDating {
  const _$_ArtDating(
      {required this.presentingDate,
      required this.sortingDate,
      required this.period,
      required this.yearEarly,
      required this.yearLate});

  factory _$_ArtDating.fromJson(Map<String, dynamic> json) =>
      _$$_ArtDatingFromJson(json);

  @override
  final String presentingDate;
  @override
  final int sortingDate;
  @override
  final int period;
  @override
  final int yearEarly;
  @override
  final int yearLate;

  @override
  String toString() {
    return 'ArtDating(presentingDate: $presentingDate, sortingDate: $sortingDate, period: $period, yearEarly: $yearEarly, yearLate: $yearLate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtDating &&
            const DeepCollectionEquality()
                .equals(other.presentingDate, presentingDate) &&
            const DeepCollectionEquality()
                .equals(other.sortingDate, sortingDate) &&
            const DeepCollectionEquality().equals(other.period, period) &&
            const DeepCollectionEquality().equals(other.yearEarly, yearEarly) &&
            const DeepCollectionEquality().equals(other.yearLate, yearLate));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(presentingDate),
      const DeepCollectionEquality().hash(sortingDate),
      const DeepCollectionEquality().hash(period),
      const DeepCollectionEquality().hash(yearEarly),
      const DeepCollectionEquality().hash(yearLate));

  @JsonKey(ignore: true)
  @override
  _$ArtDatingCopyWith<_ArtDating> get copyWith =>
      __$ArtDatingCopyWithImpl<_ArtDating>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtDatingToJson(this);
  }
}

abstract class _ArtDating implements ArtDating {
  const factory _ArtDating(
      {required String presentingDate,
      required int sortingDate,
      required int period,
      required int yearEarly,
      required int yearLate}) = _$_ArtDating;

  factory _ArtDating.fromJson(Map<String, dynamic> json) =
      _$_ArtDating.fromJson;

  @override
  String get presentingDate;
  @override
  int get sortingDate;
  @override
  int get period;
  @override
  int get yearEarly;
  @override
  int get yearLate;
  @override
  @JsonKey(ignore: true)
  _$ArtDatingCopyWith<_ArtDating> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDimension _$ArtDimensionFromJson(Map<String, dynamic> json) {
  return _ArtDimension.fromJson(json);
}

/// @nodoc
class _$ArtDimensionTearOff {
  const _$ArtDimensionTearOff();

  _ArtDimension call(
      {required String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) required double value,
      String? part}) {
    return _ArtDimension(
      unit: unit,
      type: type,
      value: value,
      part: part,
    );
  }

  ArtDimension fromJson(Map<String, Object?> json) {
    return ArtDimension.fromJson(json);
  }
}

/// @nodoc
const $ArtDimension = _$ArtDimensionTearOff();

/// @nodoc
mixin _$ArtDimension {
  String get unit => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDoubleParser)
  double get value => throw _privateConstructorUsedError;
  String? get part => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtDimensionCopyWith<ArtDimension> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDimensionCopyWith<$Res> {
  factory $ArtDimensionCopyWith(
          ArtDimension value, $Res Function(ArtDimension) then) =
      _$ArtDimensionCopyWithImpl<$Res>;
  $Res call(
      {String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) double value,
      String? part});
}

/// @nodoc
class _$ArtDimensionCopyWithImpl<$Res> implements $ArtDimensionCopyWith<$Res> {
  _$ArtDimensionCopyWithImpl(this._value, this._then);

  final ArtDimension _value;
  // ignore: unused_field
  final $Res Function(ArtDimension) _then;

  @override
  $Res call({
    Object? unit = freezed,
    Object? type = freezed,
    Object? value = freezed,
    Object? part = freezed,
  }) {
    return _then(_value.copyWith(
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      part: part == freezed
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ArtDimensionCopyWith<$Res>
    implements $ArtDimensionCopyWith<$Res> {
  factory _$ArtDimensionCopyWith(
          _ArtDimension value, $Res Function(_ArtDimension) then) =
      __$ArtDimensionCopyWithImpl<$Res>;
  @override
  $Res call(
      {String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) double value,
      String? part});
}

/// @nodoc
class __$ArtDimensionCopyWithImpl<$Res> extends _$ArtDimensionCopyWithImpl<$Res>
    implements _$ArtDimensionCopyWith<$Res> {
  __$ArtDimensionCopyWithImpl(
      _ArtDimension _value, $Res Function(_ArtDimension) _then)
      : super(_value, (v) => _then(v as _ArtDimension));

  @override
  _ArtDimension get _value => super._value as _ArtDimension;

  @override
  $Res call({
    Object? unit = freezed,
    Object? type = freezed,
    Object? value = freezed,
    Object? part = freezed,
  }) {
    return _then(_ArtDimension(
      unit: unit == freezed
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      type: type == freezed
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: value == freezed
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      part: part == freezed
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtDimension implements _ArtDimension {
  const _$_ArtDimension(
      {required this.unit,
      this.type,
      @JsonKey(fromJson: stringToDoubleParser) required this.value,
      this.part});

  factory _$_ArtDimension.fromJson(Map<String, dynamic> json) =>
      _$$_ArtDimensionFromJson(json);

  @override
  final String unit;
  @override
  final String? type;
  @override
  @JsonKey(fromJson: stringToDoubleParser)
  final double value;
  @override
  final String? part;

  @override
  String toString() {
    return 'ArtDimension(unit: $unit, type: $type, value: $value, part: $part)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtDimension &&
            const DeepCollectionEquality().equals(other.unit, unit) &&
            const DeepCollectionEquality().equals(other.type, type) &&
            const DeepCollectionEquality().equals(other.value, value) &&
            const DeepCollectionEquality().equals(other.part, part));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(unit),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(value),
      const DeepCollectionEquality().hash(part));

  @JsonKey(ignore: true)
  @override
  _$ArtDimensionCopyWith<_ArtDimension> get copyWith =>
      __$ArtDimensionCopyWithImpl<_ArtDimension>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtDimensionToJson(this);
  }
}

abstract class _ArtDimension implements ArtDimension {
  const factory _ArtDimension(
      {required String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) required double value,
      String? part}) = _$_ArtDimension;

  factory _ArtDimension.fromJson(Map<String, dynamic> json) =
      _$_ArtDimension.fromJson;

  @override
  String get unit;
  @override
  String? get type;
  @override
  @JsonKey(fromJson: stringToDoubleParser)
  double get value;
  @override
  String? get part;
  @override
  @JsonKey(ignore: true)
  _$ArtDimensionCopyWith<_ArtDimension> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtLabel _$ArtLabelFromJson(Map<String, dynamic> json) {
  return _ArtLabel.fromJson(json);
}

/// @nodoc
class _$ArtLabelTearOff {
  const _$ArtLabelTearOff();

  _ArtLabel call(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date}) {
    return _ArtLabel(
      title: title,
      makerLine: makerLine,
      description: description,
      notes: notes,
      date: date,
    );
  }

  ArtLabel fromJson(Map<String, Object?> json) {
    return ArtLabel.fromJson(json);
  }
}

/// @nodoc
const $ArtLabel = _$ArtLabelTearOff();

/// @nodoc
mixin _$ArtLabel {
  String? get title => throw _privateConstructorUsedError;
  String? get makerLine => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtLabelCopyWith<ArtLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtLabelCopyWith<$Res> {
  factory $ArtLabelCopyWith(ArtLabel value, $Res Function(ArtLabel) then) =
      _$ArtLabelCopyWithImpl<$Res>;
  $Res call(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date});
}

/// @nodoc
class _$ArtLabelCopyWithImpl<$Res> implements $ArtLabelCopyWith<$Res> {
  _$ArtLabelCopyWithImpl(this._value, this._then);

  final ArtLabel _value;
  // ignore: unused_field
  final $Res Function(ArtLabel) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? makerLine = freezed,
    Object? description = freezed,
    Object? notes = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      makerLine: makerLine == freezed
          ? _value.makerLine
          : makerLine // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
abstract class _$ArtLabelCopyWith<$Res> implements $ArtLabelCopyWith<$Res> {
  factory _$ArtLabelCopyWith(_ArtLabel value, $Res Function(_ArtLabel) then) =
      __$ArtLabelCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date});
}

/// @nodoc
class __$ArtLabelCopyWithImpl<$Res> extends _$ArtLabelCopyWithImpl<$Res>
    implements _$ArtLabelCopyWith<$Res> {
  __$ArtLabelCopyWithImpl(_ArtLabel _value, $Res Function(_ArtLabel) _then)
      : super(_value, (v) => _then(v as _ArtLabel));

  @override
  _ArtLabel get _value => super._value as _ArtLabel;

  @override
  $Res call({
    Object? title = freezed,
    Object? makerLine = freezed,
    Object? description = freezed,
    Object? notes = freezed,
    Object? date = freezed,
  }) {
    return _then(_ArtLabel(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      makerLine: makerLine == freezed
          ? _value.makerLine
          : makerLine // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: notes == freezed
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtLabel implements _ArtLabel {
  const _$_ArtLabel(
      {this.title, this.makerLine, this.description, this.notes, this.date});

  factory _$_ArtLabel.fromJson(Map<String, dynamic> json) =>
      _$$_ArtLabelFromJson(json);

  @override
  final String? title;
  @override
  final String? makerLine;
  @override
  final String? description;
  @override
  final String? notes;
  @override
  final DateTime? date;

  @override
  String toString() {
    return 'ArtLabel(title: $title, makerLine: $makerLine, description: $description, notes: $notes, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtLabel &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other.makerLine, makerLine) &&
            const DeepCollectionEquality()
                .equals(other.description, description) &&
            const DeepCollectionEquality().equals(other.notes, notes) &&
            const DeepCollectionEquality().equals(other.date, date));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(makerLine),
      const DeepCollectionEquality().hash(description),
      const DeepCollectionEquality().hash(notes),
      const DeepCollectionEquality().hash(date));

  @JsonKey(ignore: true)
  @override
  _$ArtLabelCopyWith<_ArtLabel> get copyWith =>
      __$ArtLabelCopyWithImpl<_ArtLabel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtLabelToJson(this);
  }
}

abstract class _ArtLabel implements ArtLabel {
  const factory _ArtLabel(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date}) = _$_ArtLabel;

  factory _ArtLabel.fromJson(Map<String, dynamic> json) = _$_ArtLabel.fromJson;

  @override
  String? get title;
  @override
  String? get makerLine;
  @override
  String? get description;
  @override
  String? get notes;
  @override
  DateTime? get date;
  @override
  @JsonKey(ignore: true)
  _$ArtLabelCopyWith<_ArtLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtLinks _$ArtLinksFromJson(Map<String, dynamic> json) {
  return _ArtLinks.fromJson(json);
}

/// @nodoc
class _$ArtLinksTearOff {
  const _$ArtLinksTearOff();

  _ArtLinks call({String? web, String? self, String? search}) {
    return _ArtLinks(
      web: web,
      self: self,
      search: search,
    );
  }

  ArtLinks fromJson(Map<String, Object?> json) {
    return ArtLinks.fromJson(json);
  }
}

/// @nodoc
const $ArtLinks = _$ArtLinksTearOff();

/// @nodoc
mixin _$ArtLinks {
  String? get web => throw _privateConstructorUsedError;
  String? get self => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtLinksCopyWith<ArtLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtLinksCopyWith<$Res> {
  factory $ArtLinksCopyWith(ArtLinks value, $Res Function(ArtLinks) then) =
      _$ArtLinksCopyWithImpl<$Res>;
  $Res call({String? web, String? self, String? search});
}

/// @nodoc
class _$ArtLinksCopyWithImpl<$Res> implements $ArtLinksCopyWith<$Res> {
  _$ArtLinksCopyWithImpl(this._value, this._then);

  final ArtLinks _value;
  // ignore: unused_field
  final $Res Function(ArtLinks) _then;

  @override
  $Res call({
    Object? web = freezed,
    Object? self = freezed,
    Object? search = freezed,
  }) {
    return _then(_value.copyWith(
      web: web == freezed
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String?,
      self: self == freezed
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ArtLinksCopyWith<$Res> implements $ArtLinksCopyWith<$Res> {
  factory _$ArtLinksCopyWith(_ArtLinks value, $Res Function(_ArtLinks) then) =
      __$ArtLinksCopyWithImpl<$Res>;
  @override
  $Res call({String? web, String? self, String? search});
}

/// @nodoc
class __$ArtLinksCopyWithImpl<$Res> extends _$ArtLinksCopyWithImpl<$Res>
    implements _$ArtLinksCopyWith<$Res> {
  __$ArtLinksCopyWithImpl(_ArtLinks _value, $Res Function(_ArtLinks) _then)
      : super(_value, (v) => _then(v as _ArtLinks));

  @override
  _ArtLinks get _value => super._value as _ArtLinks;

  @override
  $Res call({
    Object? web = freezed,
    Object? self = freezed,
    Object? search = freezed,
  }) {
    return _then(_ArtLinks(
      web: web == freezed
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String?,
      self: self == freezed
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      search: search == freezed
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtLinks implements _ArtLinks {
  const _$_ArtLinks({this.web, this.self, this.search});

  factory _$_ArtLinks.fromJson(Map<String, dynamic> json) =>
      _$$_ArtLinksFromJson(json);

  @override
  final String? web;
  @override
  final String? self;
  @override
  final String? search;

  @override
  String toString() {
    return 'ArtLinks(web: $web, self: $self, search: $search)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtLinks &&
            const DeepCollectionEquality().equals(other.web, web) &&
            const DeepCollectionEquality().equals(other.self, self) &&
            const DeepCollectionEquality().equals(other.search, search));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(web),
      const DeepCollectionEquality().hash(self),
      const DeepCollectionEquality().hash(search));

  @JsonKey(ignore: true)
  @override
  _$ArtLinksCopyWith<_ArtLinks> get copyWith =>
      __$ArtLinksCopyWithImpl<_ArtLinks>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtLinksToJson(this);
  }
}

abstract class _ArtLinks implements ArtLinks {
  const factory _ArtLinks({String? web, String? self, String? search}) =
      _$_ArtLinks;

  factory _ArtLinks.fromJson(Map<String, dynamic> json) = _$_ArtLinks.fromJson;

  @override
  String? get web;
  @override
  String? get self;
  @override
  String? get search;
  @override
  @JsonKey(ignore: true)
  _$ArtLinksCopyWith<_ArtLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtMaker _$ArtMakerFromJson(Map<String, dynamic> json) {
  return _ArtMaker.fromJson(json);
}

/// @nodoc
class _$ArtMakerTearOff {
  const _$ArtMakerTearOff();

  _ArtMaker call(
      {required String name,
      required String unFixedName,
      String? placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfDeath,
      String? placeOfDeath,
      required List<String> occupation,
      required List<String> roles,
      String? nationality,
      String? biography,
      required String labelDesc}) {
    return _ArtMaker(
      name: name,
      unFixedName: unFixedName,
      placeOfBirth: placeOfBirth,
      dateOfBirth: dateOfBirth,
      dateOfDeath: dateOfDeath,
      placeOfDeath: placeOfDeath,
      occupation: occupation,
      roles: roles,
      nationality: nationality,
      biography: biography,
      labelDesc: labelDesc,
    );
  }

  ArtMaker fromJson(Map<String, Object?> json) {
    return ArtMaker.fromJson(json);
  }
}

/// @nodoc
const $ArtMaker = _$ArtMakerTearOff();

/// @nodoc
mixin _$ArtMaker {
  String get name => throw _privateConstructorUsedError;
  String get unFixedName => throw _privateConstructorUsedError;
  String? get placeOfBirth => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDateNullableParser)
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDateNullableParser)
  DateTime? get dateOfDeath => throw _privateConstructorUsedError;
  String? get placeOfDeath => throw _privateConstructorUsedError;
  List<String> get occupation => throw _privateConstructorUsedError;
  List<String> get roles => throw _privateConstructorUsedError;
  String? get nationality => throw _privateConstructorUsedError;
  String? get biography => throw _privateConstructorUsedError;
  String get labelDesc => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtMakerCopyWith<ArtMaker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtMakerCopyWith<$Res> {
  factory $ArtMakerCopyWith(ArtMaker value, $Res Function(ArtMaker) then) =
      _$ArtMakerCopyWithImpl<$Res>;
  $Res call(
      {String name,
      String unFixedName,
      String? placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfDeath,
      String? placeOfDeath,
      List<String> occupation,
      List<String> roles,
      String? nationality,
      String? biography,
      String labelDesc});
}

/// @nodoc
class _$ArtMakerCopyWithImpl<$Res> implements $ArtMakerCopyWith<$Res> {
  _$ArtMakerCopyWithImpl(this._value, this._then);

  final ArtMaker _value;
  // ignore: unused_field
  final $Res Function(ArtMaker) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? unFixedName = freezed,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? dateOfDeath = freezed,
    Object? placeOfDeath = freezed,
    Object? occupation = freezed,
    Object? roles = freezed,
    Object? nationality = freezed,
    Object? biography = freezed,
    Object? labelDesc = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unFixedName: unFixedName == freezed
          ? _value.unFixedName
          : unFixedName // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfBirth: placeOfBirth == freezed
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfDeath: dateOfDeath == freezed
          ? _value.dateOfDeath
          : dateOfDeath // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfDeath: placeOfDeath == freezed
          ? _value.placeOfDeath
          : placeOfDeath // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: occupation == freezed
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: nationality == freezed
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: biography == freezed
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String?,
      labelDesc: labelDesc == freezed
          ? _value.labelDesc
          : labelDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$ArtMakerCopyWith<$Res> implements $ArtMakerCopyWith<$Res> {
  factory _$ArtMakerCopyWith(_ArtMaker value, $Res Function(_ArtMaker) then) =
      __$ArtMakerCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name,
      String unFixedName,
      String? placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfDeath,
      String? placeOfDeath,
      List<String> occupation,
      List<String> roles,
      String? nationality,
      String? biography,
      String labelDesc});
}

/// @nodoc
class __$ArtMakerCopyWithImpl<$Res> extends _$ArtMakerCopyWithImpl<$Res>
    implements _$ArtMakerCopyWith<$Res> {
  __$ArtMakerCopyWithImpl(_ArtMaker _value, $Res Function(_ArtMaker) _then)
      : super(_value, (v) => _then(v as _ArtMaker));

  @override
  _ArtMaker get _value => super._value as _ArtMaker;

  @override
  $Res call({
    Object? name = freezed,
    Object? unFixedName = freezed,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? dateOfDeath = freezed,
    Object? placeOfDeath = freezed,
    Object? occupation = freezed,
    Object? roles = freezed,
    Object? nationality = freezed,
    Object? biography = freezed,
    Object? labelDesc = freezed,
  }) {
    return _then(_ArtMaker(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unFixedName: unFixedName == freezed
          ? _value.unFixedName
          : unFixedName // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfBirth: placeOfBirth == freezed
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: dateOfBirth == freezed
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfDeath: dateOfDeath == freezed
          ? _value.dateOfDeath
          : dateOfDeath // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfDeath: placeOfDeath == freezed
          ? _value.placeOfDeath
          : placeOfDeath // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: occupation == freezed
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roles: roles == freezed
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: nationality == freezed
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: biography == freezed
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String?,
      labelDesc: labelDesc == freezed
          ? _value.labelDesc
          : labelDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtMaker implements _ArtMaker {
  const _$_ArtMaker(
      {required this.name,
      required this.unFixedName,
      this.placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) this.dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) this.dateOfDeath,
      this.placeOfDeath,
      required this.occupation,
      required this.roles,
      this.nationality,
      this.biography,
      required this.labelDesc});

  factory _$_ArtMaker.fromJson(Map<String, dynamic> json) =>
      _$$_ArtMakerFromJson(json);

  @override
  final String name;
  @override
  final String unFixedName;
  @override
  final String? placeOfBirth;
  @override
  @JsonKey(fromJson: stringToDateNullableParser)
  final DateTime? dateOfBirth;
  @override
  @JsonKey(fromJson: stringToDateNullableParser)
  final DateTime? dateOfDeath;
  @override
  final String? placeOfDeath;
  @override
  final List<String> occupation;
  @override
  final List<String> roles;
  @override
  final String? nationality;
  @override
  final String? biography;
  @override
  final String labelDesc;

  @override
  String toString() {
    return 'ArtMaker(name: $name, unFixedName: $unFixedName, placeOfBirth: $placeOfBirth, dateOfBirth: $dateOfBirth, dateOfDeath: $dateOfDeath, placeOfDeath: $placeOfDeath, occupation: $occupation, roles: $roles, nationality: $nationality, biography: $biography, labelDesc: $labelDesc)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtMaker &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality()
                .equals(other.unFixedName, unFixedName) &&
            const DeepCollectionEquality()
                .equals(other.placeOfBirth, placeOfBirth) &&
            const DeepCollectionEquality()
                .equals(other.dateOfBirth, dateOfBirth) &&
            const DeepCollectionEquality()
                .equals(other.dateOfDeath, dateOfDeath) &&
            const DeepCollectionEquality()
                .equals(other.placeOfDeath, placeOfDeath) &&
            const DeepCollectionEquality()
                .equals(other.occupation, occupation) &&
            const DeepCollectionEquality().equals(other.roles, roles) &&
            const DeepCollectionEquality()
                .equals(other.nationality, nationality) &&
            const DeepCollectionEquality().equals(other.biography, biography) &&
            const DeepCollectionEquality().equals(other.labelDesc, labelDesc));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(unFixedName),
      const DeepCollectionEquality().hash(placeOfBirth),
      const DeepCollectionEquality().hash(dateOfBirth),
      const DeepCollectionEquality().hash(dateOfDeath),
      const DeepCollectionEquality().hash(placeOfDeath),
      const DeepCollectionEquality().hash(occupation),
      const DeepCollectionEquality().hash(roles),
      const DeepCollectionEquality().hash(nationality),
      const DeepCollectionEquality().hash(biography),
      const DeepCollectionEquality().hash(labelDesc));

  @JsonKey(ignore: true)
  @override
  _$ArtMakerCopyWith<_ArtMaker> get copyWith =>
      __$ArtMakerCopyWithImpl<_ArtMaker>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtMakerToJson(this);
  }
}

abstract class _ArtMaker implements ArtMaker {
  const factory _ArtMaker(
      {required String name,
      required String unFixedName,
      String? placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) DateTime? dateOfDeath,
      String? placeOfDeath,
      required List<String> occupation,
      required List<String> roles,
      String? nationality,
      String? biography,
      required String labelDesc}) = _$_ArtMaker;

  factory _ArtMaker.fromJson(Map<String, dynamic> json) = _$_ArtMaker.fromJson;

  @override
  String get name;
  @override
  String get unFixedName;
  @override
  String? get placeOfBirth;
  @override
  @JsonKey(fromJson: stringToDateNullableParser)
  DateTime? get dateOfBirth;
  @override
  @JsonKey(fromJson: stringToDateNullableParser)
  DateTime? get dateOfDeath;
  @override
  String? get placeOfDeath;
  @override
  List<String> get occupation;
  @override
  List<String> get roles;
  @override
  String? get nationality;
  @override
  String? get biography;
  @override
  String get labelDesc;
  @override
  @JsonKey(ignore: true)
  _$ArtMakerCopyWith<_ArtMaker> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtImage _$ArtImageFromJson(Map<String, dynamic> json) {
  return _ArtImage.fromJson(json);
}

/// @nodoc
class _$ArtImageTearOff {
  const _$ArtImageTearOff();

  _ArtImage call(
      {String? guid, required int width, required int height, String? url}) {
    return _ArtImage(
      guid: guid,
      width: width,
      height: height,
      url: url,
    );
  }

  ArtImage fromJson(Map<String, Object?> json) {
    return ArtImage.fromJson(json);
  }
}

/// @nodoc
const $ArtImage = _$ArtImageTearOff();

/// @nodoc
mixin _$ArtImage {
  String? get guid => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArtImageCopyWith<ArtImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtImageCopyWith<$Res> {
  factory $ArtImageCopyWith(ArtImage value, $Res Function(ArtImage) then) =
      _$ArtImageCopyWithImpl<$Res>;
  $Res call({String? guid, int width, int height, String? url});
}

/// @nodoc
class _$ArtImageCopyWithImpl<$Res> implements $ArtImageCopyWith<$Res> {
  _$ArtImageCopyWithImpl(this._value, this._then);

  final ArtImage _value;
  // ignore: unused_field
  final $Res Function(ArtImage) _then;

  @override
  $Res call({
    Object? guid = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      guid: guid == freezed
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$ArtImageCopyWith<$Res> implements $ArtImageCopyWith<$Res> {
  factory _$ArtImageCopyWith(_ArtImage value, $Res Function(_ArtImage) then) =
      __$ArtImageCopyWithImpl<$Res>;
  @override
  $Res call({String? guid, int width, int height, String? url});
}

/// @nodoc
class __$ArtImageCopyWithImpl<$Res> extends _$ArtImageCopyWithImpl<$Res>
    implements _$ArtImageCopyWith<$Res> {
  __$ArtImageCopyWithImpl(_ArtImage _value, $Res Function(_ArtImage) _then)
      : super(_value, (v) => _then(v as _ArtImage));

  @override
  _ArtImage get _value => super._value as _ArtImage;

  @override
  $Res call({
    Object? guid = freezed,
    Object? width = freezed,
    Object? height = freezed,
    Object? url = freezed,
  }) {
    return _then(_ArtImage(
      guid: guid == freezed
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: width == freezed
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: height == freezed
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ArtImage implements _ArtImage {
  const _$_ArtImage(
      {this.guid, required this.width, required this.height, this.url});

  factory _$_ArtImage.fromJson(Map<String, dynamic> json) =>
      _$$_ArtImageFromJson(json);

  @override
  final String? guid;
  @override
  final int width;
  @override
  final int height;
  @override
  final String? url;

  @override
  String toString() {
    return 'ArtImage(guid: $guid, width: $width, height: $height, url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ArtImage &&
            const DeepCollectionEquality().equals(other.guid, guid) &&
            const DeepCollectionEquality().equals(other.width, width) &&
            const DeepCollectionEquality().equals(other.height, height) &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(guid),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$ArtImageCopyWith<_ArtImage> get copyWith =>
      __$ArtImageCopyWithImpl<_ArtImage>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ArtImageToJson(this);
  }
}

abstract class _ArtImage implements ArtImage {
  const factory _ArtImage(
      {String? guid,
      required int width,
      required int height,
      String? url}) = _$_ArtImage;

  factory _ArtImage.fromJson(Map<String, dynamic> json) = _$_ArtImage.fromJson;

  @override
  String? get guid;
  @override
  int get width;
  @override
  int get height;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$ArtImageCopyWith<_ArtImage> get copyWith =>
      throw _privateConstructorUsedError;
}
