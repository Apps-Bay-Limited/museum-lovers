// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Art _$ArtFromJson(Map<String, dynamic> json) {
  return _Art.fromJson(json);
}

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

  /// Serializes this Art to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtCopyWith<Art> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtCopyWith<$Res> {
  factory $ArtCopyWith(Art value, $Res Function(Art) then) =
      _$ArtCopyWithImpl<$Res, Art>;
  @useResult
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
class _$ArtCopyWithImpl<$Res, $Val extends Art> implements $ArtCopyWith<$Res> {
  _$ArtCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? objectNumber = null,
    Object? title = null,
    Object? longTitle = null,
    Object? principalOrFirstMaker = null,
    Object? hasImage = null,
    Object? showImage = null,
    Object? webImage = freezed,
    Object? headerImage = freezed,
    Object? links = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: null == objectNumber
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      longTitle: null == longTitle
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: null == principalOrFirstMaker
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      hasImage: null == hasImage
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: null == showImage
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      webImage: freezed == webImage
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      headerImage: freezed == headerImage
          ? _value.headerImage
          : headerImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ArtLinks,
    ) as $Val);
  }

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtImageCopyWith<$Res>? get webImage {
    if (_value.webImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.webImage!, (value) {
      return _then(_value.copyWith(webImage: value) as $Val);
    });
  }

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtImageCopyWith<$Res>? get headerImage {
    if (_value.headerImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.headerImage!, (value) {
      return _then(_value.copyWith(headerImage: value) as $Val);
    });
  }

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtLinksCopyWith<$Res> get links {
    return $ArtLinksCopyWith<$Res>(_value.links, (value) {
      return _then(_value.copyWith(links: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArtImplCopyWith<$Res> implements $ArtCopyWith<$Res> {
  factory _$$ArtImplCopyWith(_$ArtImpl value, $Res Function(_$ArtImpl) then) =
      __$$ArtImplCopyWithImpl<$Res>;
  @override
  @useResult
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
class __$$ArtImplCopyWithImpl<$Res> extends _$ArtCopyWithImpl<$Res, _$ArtImpl>
    implements _$$ArtImplCopyWith<$Res> {
  __$$ArtImplCopyWithImpl(_$ArtImpl _value, $Res Function(_$ArtImpl) _then)
      : super(_value, _then);

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? objectNumber = null,
    Object? title = null,
    Object? longTitle = null,
    Object? principalOrFirstMaker = null,
    Object? hasImage = null,
    Object? showImage = null,
    Object? webImage = freezed,
    Object? headerImage = freezed,
    Object? links = null,
  }) {
    return _then(_$ArtImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: null == objectNumber
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      longTitle: null == longTitle
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: null == principalOrFirstMaker
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      hasImage: null == hasImage
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: null == showImage
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      webImage: freezed == webImage
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      headerImage: freezed == headerImage
          ? _value.headerImage
          : headerImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      links: null == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as ArtLinks,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtImpl implements _Art {
  const _$ArtImpl(
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

  factory _$ArtImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.objectNumber, objectNumber) ||
                other.objectNumber == objectNumber) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.longTitle, longTitle) ||
                other.longTitle == longTitle) &&
            (identical(other.principalOrFirstMaker, principalOrFirstMaker) ||
                other.principalOrFirstMaker == principalOrFirstMaker) &&
            (identical(other.hasImage, hasImage) ||
                other.hasImage == hasImage) &&
            (identical(other.showImage, showImage) ||
                other.showImage == showImage) &&
            (identical(other.webImage, webImage) ||
                other.webImage == webImage) &&
            (identical(other.headerImage, headerImage) ||
                other.headerImage == headerImage) &&
            (identical(other.links, links) || other.links == links));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      objectNumber,
      title,
      longTitle,
      principalOrFirstMaker,
      hasImage,
      showImage,
      webImage,
      headerImage,
      links);

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtImplCopyWith<_$ArtImpl> get copyWith =>
      __$$ArtImplCopyWithImpl<_$ArtImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtImplToJson(
      this,
    );
  }
}

abstract class _Art implements Art {
  const factory _Art(
      {required final String id,
      required final String objectNumber,
      required final String title,
      required final String longTitle,
      required final String principalOrFirstMaker,
      required final bool hasImage,
      required final bool showImage,
      required final ArtImage? webImage,
      required final ArtImage? headerImage,
      required final ArtLinks links}) = _$ArtImpl;

  factory _Art.fromJson(Map<String, dynamic> json) = _$ArtImpl.fromJson;

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

  /// Create a copy of Art
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtImplCopyWith<_$ArtImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDetail _$ArtDetailFromJson(Map<String, dynamic> json) {
  return _ArtDetail.fromJson(json);
}

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
  List<String> get inscriptions => throw _privateConstructorUsedError;
  String? get galleryLocation => throw _privateConstructorUsedError;
  bool get onDisplay => throw _privateConstructorUsedError;

  /// Serializes this ArtDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtDetailCopyWith<ArtDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDetailCopyWith<$Res> {
  factory $ArtDetailCopyWith(ArtDetail value, $Res Function(ArtDetail) then) =
      _$ArtDetailCopyWithImpl<$Res, ArtDetail>;
  @useResult
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
      ArtDating dating,
      List<String> inscriptions,
      String? galleryLocation,
      bool onDisplay});

  $ArtLabelCopyWith<$Res> get label;
  $ArtImageCopyWith<$Res>? get webImage;
  $ArtDatingCopyWith<$Res> get dating;
}

/// @nodoc
class _$ArtDetailCopyWithImpl<$Res, $Val extends ArtDetail>
    implements $ArtDetailCopyWith<$Res> {
  _$ArtDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? objectNumber = null,
    Object? colors = null,
    Object? normalizedColors = null,
    Object? title = null,
    Object? titles = null,
    Object? longTitle = null,
    Object? subTitle = null,
    Object? scLabelLine = null,
    Object? label = null,
    Object? description = freezed,
    Object? objectTypes = null,
    Object? objectCollection = null,
    Object? principalMaker = null,
    Object? principalOrFirstMaker = null,
    Object? principalMakers = null,
    Object? plaqueDescriptionEnglish = freezed,
    Object? materials = null,
    Object? productionPlaces = null,
    Object? techniques = null,
    Object? physicalProperties = null,
    Object? hasImage = null,
    Object? showImage = null,
    Object? historicalPersons = null,
    Object? documentation = null,
    Object? dimensions = null,
    Object? physicalMedium = freezed,
    Object? webImage = freezed,
    Object? dating = null,
    Object? inscriptions = null,
    Object? galleryLocation = freezed,
    Object? onDisplay = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: null == objectNumber
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _value.colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      normalizedColors: null == normalizedColors
          ? _value.normalizedColors
          : normalizedColors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titles: null == titles
          ? _value.titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longTitle: null == longTitle
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      scLabelLine: null == scLabelLine
          ? _value.scLabelLine
          : scLabelLine // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as ArtLabel,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      objectTypes: null == objectTypes
          ? _value.objectTypes
          : objectTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      objectCollection: null == objectCollection
          ? _value.objectCollection
          : objectCollection // ignore: cast_nullable_to_non_nullable
              as List<String>,
      principalMaker: null == principalMaker
          ? _value.principalMaker
          : principalMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: null == principalOrFirstMaker
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalMakers: null == principalMakers
          ? _value.principalMakers
          : principalMakers // ignore: cast_nullable_to_non_nullable
              as List<ArtMaker>,
      plaqueDescriptionEnglish: freezed == plaqueDescriptionEnglish
          ? _value.plaqueDescriptionEnglish
          : plaqueDescriptionEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: null == materials
          ? _value.materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionPlaces: null == productionPlaces
          ? _value.productionPlaces
          : productionPlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _value.techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      physicalProperties: null == physicalProperties
          ? _value.physicalProperties
          : physicalProperties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasImage: null == hasImage
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: null == showImage
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      historicalPersons: null == historicalPersons
          ? _value.historicalPersons
          : historicalPersons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: null == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dimensions: null == dimensions
          ? _value.dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as List<ArtDimension>,
      physicalMedium: freezed == physicalMedium
          ? _value.physicalMedium
          : physicalMedium // ignore: cast_nullable_to_non_nullable
              as String?,
      webImage: freezed == webImage
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      dating: null == dating
          ? _value.dating
          : dating // ignore: cast_nullable_to_non_nullable
              as ArtDating,
      inscriptions: null == inscriptions
          ? _value.inscriptions
          : inscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      galleryLocation: freezed == galleryLocation
          ? _value.galleryLocation
          : galleryLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      onDisplay: null == onDisplay
          ? _value.onDisplay
          : onDisplay // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtLabelCopyWith<$Res> get label {
    return $ArtLabelCopyWith<$Res>(_value.label, (value) {
      return _then(_value.copyWith(label: value) as $Val);
    });
  }

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtImageCopyWith<$Res>? get webImage {
    if (_value.webImage == null) {
      return null;
    }

    return $ArtImageCopyWith<$Res>(_value.webImage!, (value) {
      return _then(_value.copyWith(webImage: value) as $Val);
    });
  }

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ArtDatingCopyWith<$Res> get dating {
    return $ArtDatingCopyWith<$Res>(_value.dating, (value) {
      return _then(_value.copyWith(dating: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ArtDetailImplCopyWith<$Res>
    implements $ArtDetailCopyWith<$Res> {
  factory _$$ArtDetailImplCopyWith(
          _$ArtDetailImpl value, $Res Function(_$ArtDetailImpl) then) =
      __$$ArtDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
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
      ArtDating dating,
      List<String> inscriptions,
      String? galleryLocation,
      bool onDisplay});

  @override
  $ArtLabelCopyWith<$Res> get label;
  @override
  $ArtImageCopyWith<$Res>? get webImage;
  @override
  $ArtDatingCopyWith<$Res> get dating;
}

/// @nodoc
class __$$ArtDetailImplCopyWithImpl<$Res>
    extends _$ArtDetailCopyWithImpl<$Res, _$ArtDetailImpl>
    implements _$$ArtDetailImplCopyWith<$Res> {
  __$$ArtDetailImplCopyWithImpl(
      _$ArtDetailImpl _value, $Res Function(_$ArtDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? objectNumber = null,
    Object? colors = null,
    Object? normalizedColors = null,
    Object? title = null,
    Object? titles = null,
    Object? longTitle = null,
    Object? subTitle = null,
    Object? scLabelLine = null,
    Object? label = null,
    Object? description = freezed,
    Object? objectTypes = null,
    Object? objectCollection = null,
    Object? principalMaker = null,
    Object? principalOrFirstMaker = null,
    Object? principalMakers = null,
    Object? plaqueDescriptionEnglish = freezed,
    Object? materials = null,
    Object? productionPlaces = null,
    Object? techniques = null,
    Object? physicalProperties = null,
    Object? hasImage = null,
    Object? showImage = null,
    Object? historicalPersons = null,
    Object? documentation = null,
    Object? dimensions = null,
    Object? physicalMedium = freezed,
    Object? webImage = freezed,
    Object? dating = null,
    Object? inscriptions = null,
    Object? galleryLocation = freezed,
    Object? onDisplay = null,
  }) {
    return _then(_$ArtDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      objectNumber: null == objectNumber
          ? _value.objectNumber
          : objectNumber // ignore: cast_nullable_to_non_nullable
              as String,
      colors: null == colors
          ? _value._colors
          : colors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      normalizedColors: null == normalizedColors
          ? _value._normalizedColors
          : normalizedColors // ignore: cast_nullable_to_non_nullable
              as List<ArtColor>,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      titles: null == titles
          ? _value._titles
          : titles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      longTitle: null == longTitle
          ? _value.longTitle
          : longTitle // ignore: cast_nullable_to_non_nullable
              as String,
      subTitle: null == subTitle
          ? _value.subTitle
          : subTitle // ignore: cast_nullable_to_non_nullable
              as String,
      scLabelLine: null == scLabelLine
          ? _value.scLabelLine
          : scLabelLine // ignore: cast_nullable_to_non_nullable
              as String,
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as ArtLabel,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      objectTypes: null == objectTypes
          ? _value._objectTypes
          : objectTypes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      objectCollection: null == objectCollection
          ? _value._objectCollection
          : objectCollection // ignore: cast_nullable_to_non_nullable
              as List<String>,
      principalMaker: null == principalMaker
          ? _value.principalMaker
          : principalMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalOrFirstMaker: null == principalOrFirstMaker
          ? _value.principalOrFirstMaker
          : principalOrFirstMaker // ignore: cast_nullable_to_non_nullable
              as String,
      principalMakers: null == principalMakers
          ? _value._principalMakers
          : principalMakers // ignore: cast_nullable_to_non_nullable
              as List<ArtMaker>,
      plaqueDescriptionEnglish: freezed == plaqueDescriptionEnglish
          ? _value.plaqueDescriptionEnglish
          : plaqueDescriptionEnglish // ignore: cast_nullable_to_non_nullable
              as String?,
      materials: null == materials
          ? _value._materials
          : materials // ignore: cast_nullable_to_non_nullable
              as List<String>,
      productionPlaces: null == productionPlaces
          ? _value._productionPlaces
          : productionPlaces // ignore: cast_nullable_to_non_nullable
              as List<String>,
      techniques: null == techniques
          ? _value._techniques
          : techniques // ignore: cast_nullable_to_non_nullable
              as List<String>,
      physicalProperties: null == physicalProperties
          ? _value._physicalProperties
          : physicalProperties // ignore: cast_nullable_to_non_nullable
              as List<String>,
      hasImage: null == hasImage
          ? _value.hasImage
          : hasImage // ignore: cast_nullable_to_non_nullable
              as bool,
      showImage: null == showImage
          ? _value.showImage
          : showImage // ignore: cast_nullable_to_non_nullable
              as bool,
      historicalPersons: null == historicalPersons
          ? _value._historicalPersons
          : historicalPersons // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: null == documentation
          ? _value._documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      dimensions: null == dimensions
          ? _value._dimensions
          : dimensions // ignore: cast_nullable_to_non_nullable
              as List<ArtDimension>,
      physicalMedium: freezed == physicalMedium
          ? _value.physicalMedium
          : physicalMedium // ignore: cast_nullable_to_non_nullable
              as String?,
      webImage: freezed == webImage
          ? _value.webImage
          : webImage // ignore: cast_nullable_to_non_nullable
              as ArtImage?,
      dating: null == dating
          ? _value.dating
          : dating // ignore: cast_nullable_to_non_nullable
              as ArtDating,
      inscriptions: null == inscriptions
          ? _value._inscriptions
          : inscriptions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      galleryLocation: freezed == galleryLocation
          ? _value.galleryLocation
          : galleryLocation // ignore: cast_nullable_to_non_nullable
              as String?,
      onDisplay: null == onDisplay
          ? _value.onDisplay
          : onDisplay // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtDetailImpl implements _ArtDetail {
  const _$ArtDetailImpl(
      {required this.id,
      required this.objectNumber,
      required final List<ArtColor> colors,
      required final List<ArtColor> normalizedColors,
      required this.title,
      required final List<String> titles,
      required this.longTitle,
      required this.subTitle,
      required this.scLabelLine,
      required this.label,
      this.description,
      required final List<String> objectTypes,
      required final List<String> objectCollection,
      required this.principalMaker,
      required this.principalOrFirstMaker,
      required final List<ArtMaker> principalMakers,
      this.plaqueDescriptionEnglish,
      required final List<String> materials,
      required final List<String> productionPlaces,
      required final List<String> techniques,
      required final List<String> physicalProperties,
      required this.hasImage,
      required this.showImage,
      required final List<String> historicalPersons,
      required final List<String> documentation,
      required final List<ArtDimension> dimensions,
      this.physicalMedium,
      this.webImage,
      required this.dating,
      required final List<String> inscriptions,
      this.galleryLocation,
      required this.onDisplay})
      : _colors = colors,
        _normalizedColors = normalizedColors,
        _titles = titles,
        _objectTypes = objectTypes,
        _objectCollection = objectCollection,
        _principalMakers = principalMakers,
        _materials = materials,
        _productionPlaces = productionPlaces,
        _techniques = techniques,
        _physicalProperties = physicalProperties,
        _historicalPersons = historicalPersons,
        _documentation = documentation,
        _dimensions = dimensions,
        _inscriptions = inscriptions;

  factory _$ArtDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtDetailImplFromJson(json);

  @override
  final String id;
  @override
  final String objectNumber;
  final List<ArtColor> _colors;
  @override
  List<ArtColor> get colors {
    if (_colors is EqualUnmodifiableListView) return _colors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_colors);
  }

  final List<ArtColor> _normalizedColors;
  @override
  List<ArtColor> get normalizedColors {
    if (_normalizedColors is EqualUnmodifiableListView)
      return _normalizedColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_normalizedColors);
  }

  @override
  final String title;
  final List<String> _titles;
  @override
  List<String> get titles {
    if (_titles is EqualUnmodifiableListView) return _titles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_titles);
  }

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
  final List<String> _objectTypes;
  @override
  List<String> get objectTypes {
    if (_objectTypes is EqualUnmodifiableListView) return _objectTypes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectTypes);
  }

  final List<String> _objectCollection;
  @override
  List<String> get objectCollection {
    if (_objectCollection is EqualUnmodifiableListView)
      return _objectCollection;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_objectCollection);
  }

  @override
  final String principalMaker;
  @override
  final String principalOrFirstMaker;
  final List<ArtMaker> _principalMakers;
  @override
  List<ArtMaker> get principalMakers {
    if (_principalMakers is EqualUnmodifiableListView) return _principalMakers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_principalMakers);
  }

  @override
  final String? plaqueDescriptionEnglish;
  final List<String> _materials;
  @override
  List<String> get materials {
    if (_materials is EqualUnmodifiableListView) return _materials;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_materials);
  }

  final List<String> _productionPlaces;
  @override
  List<String> get productionPlaces {
    if (_productionPlaces is EqualUnmodifiableListView)
      return _productionPlaces;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_productionPlaces);
  }

  final List<String> _techniques;
  @override
  List<String> get techniques {
    if (_techniques is EqualUnmodifiableListView) return _techniques;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_techniques);
  }

  final List<String> _physicalProperties;
  @override
  List<String> get physicalProperties {
    if (_physicalProperties is EqualUnmodifiableListView)
      return _physicalProperties;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_physicalProperties);
  }

  @override
  final bool hasImage;
  @override
  final bool showImage;
  final List<String> _historicalPersons;
  @override
  List<String> get historicalPersons {
    if (_historicalPersons is EqualUnmodifiableListView)
      return _historicalPersons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historicalPersons);
  }

  final List<String> _documentation;
  @override
  List<String> get documentation {
    if (_documentation is EqualUnmodifiableListView) return _documentation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_documentation);
  }

  final List<ArtDimension> _dimensions;
  @override
  List<ArtDimension> get dimensions {
    if (_dimensions is EqualUnmodifiableListView) return _dimensions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_dimensions);
  }

  @override
  final String? physicalMedium;
  @override
  final ArtImage? webImage;
  @override
  final ArtDating dating;
  final List<String> _inscriptions;
  @override
  List<String> get inscriptions {
    if (_inscriptions is EqualUnmodifiableListView) return _inscriptions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inscriptions);
  }

  @override
  final String? galleryLocation;
  @override
  final bool onDisplay;

  @override
  String toString() {
    return 'ArtDetail(id: $id, objectNumber: $objectNumber, colors: $colors, normalizedColors: $normalizedColors, title: $title, titles: $titles, longTitle: $longTitle, subTitle: $subTitle, scLabelLine: $scLabelLine, label: $label, description: $description, objectTypes: $objectTypes, objectCollection: $objectCollection, principalMaker: $principalMaker, principalOrFirstMaker: $principalOrFirstMaker, principalMakers: $principalMakers, plaqueDescriptionEnglish: $plaqueDescriptionEnglish, materials: $materials, productionPlaces: $productionPlaces, techniques: $techniques, physicalProperties: $physicalProperties, hasImage: $hasImage, showImage: $showImage, historicalPersons: $historicalPersons, documentation: $documentation, dimensions: $dimensions, physicalMedium: $physicalMedium, webImage: $webImage, dating: $dating, inscriptions: $inscriptions, galleryLocation: $galleryLocation, onDisplay: $onDisplay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.objectNumber, objectNumber) ||
                other.objectNumber == objectNumber) &&
            const DeepCollectionEquality().equals(other._colors, _colors) &&
            const DeepCollectionEquality()
                .equals(other._normalizedColors, _normalizedColors) &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality().equals(other._titles, _titles) &&
            (identical(other.longTitle, longTitle) ||
                other.longTitle == longTitle) &&
            (identical(other.subTitle, subTitle) ||
                other.subTitle == subTitle) &&
            (identical(other.scLabelLine, scLabelLine) ||
                other.scLabelLine == scLabelLine) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality()
                .equals(other._objectTypes, _objectTypes) &&
            const DeepCollectionEquality()
                .equals(other._objectCollection, _objectCollection) &&
            (identical(other.principalMaker, principalMaker) ||
                other.principalMaker == principalMaker) &&
            (identical(other.principalOrFirstMaker, principalOrFirstMaker) ||
                other.principalOrFirstMaker == principalOrFirstMaker) &&
            const DeepCollectionEquality()
                .equals(other._principalMakers, _principalMakers) &&
            (identical(
                    other.plaqueDescriptionEnglish, plaqueDescriptionEnglish) ||
                other.plaqueDescriptionEnglish == plaqueDescriptionEnglish) &&
            const DeepCollectionEquality()
                .equals(other._materials, _materials) &&
            const DeepCollectionEquality()
                .equals(other._productionPlaces, _productionPlaces) &&
            const DeepCollectionEquality()
                .equals(other._techniques, _techniques) &&
            const DeepCollectionEquality()
                .equals(other._physicalProperties, _physicalProperties) &&
            (identical(other.hasImage, hasImage) ||
                other.hasImage == hasImage) &&
            (identical(other.showImage, showImage) ||
                other.showImage == showImage) &&
            const DeepCollectionEquality()
                .equals(other._historicalPersons, _historicalPersons) &&
            const DeepCollectionEquality()
                .equals(other._documentation, _documentation) &&
            const DeepCollectionEquality()
                .equals(other._dimensions, _dimensions) &&
            (identical(other.physicalMedium, physicalMedium) ||
                other.physicalMedium == physicalMedium) &&
            (identical(other.webImage, webImage) ||
                other.webImage == webImage) &&
            (identical(other.dating, dating) || other.dating == dating) &&
            const DeepCollectionEquality()
                .equals(other._inscriptions, _inscriptions) &&
            (identical(other.galleryLocation, galleryLocation) ||
                other.galleryLocation == galleryLocation) &&
            (identical(other.onDisplay, onDisplay) ||
                other.onDisplay == onDisplay));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        objectNumber,
        const DeepCollectionEquality().hash(_colors),
        const DeepCollectionEquality().hash(_normalizedColors),
        title,
        const DeepCollectionEquality().hash(_titles),
        longTitle,
        subTitle,
        scLabelLine,
        label,
        description,
        const DeepCollectionEquality().hash(_objectTypes),
        const DeepCollectionEquality().hash(_objectCollection),
        principalMaker,
        principalOrFirstMaker,
        const DeepCollectionEquality().hash(_principalMakers),
        plaqueDescriptionEnglish,
        const DeepCollectionEquality().hash(_materials),
        const DeepCollectionEquality().hash(_productionPlaces),
        const DeepCollectionEquality().hash(_techniques),
        const DeepCollectionEquality().hash(_physicalProperties),
        hasImage,
        showImage,
        const DeepCollectionEquality().hash(_historicalPersons),
        const DeepCollectionEquality().hash(_documentation),
        const DeepCollectionEquality().hash(_dimensions),
        physicalMedium,
        webImage,
        dating,
        const DeepCollectionEquality().hash(_inscriptions),
        galleryLocation,
        onDisplay
      ]);

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtDetailImplCopyWith<_$ArtDetailImpl> get copyWith =>
      __$$ArtDetailImplCopyWithImpl<_$ArtDetailImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtDetailImplToJson(
      this,
    );
  }
}

abstract class _ArtDetail implements ArtDetail {
  const factory _ArtDetail(
      {required final String id,
      required final String objectNumber,
      required final List<ArtColor> colors,
      required final List<ArtColor> normalizedColors,
      required final String title,
      required final List<String> titles,
      required final String longTitle,
      required final String subTitle,
      required final String scLabelLine,
      required final ArtLabel label,
      final String? description,
      required final List<String> objectTypes,
      required final List<String> objectCollection,
      required final String principalMaker,
      required final String principalOrFirstMaker,
      required final List<ArtMaker> principalMakers,
      final String? plaqueDescriptionEnglish,
      required final List<String> materials,
      required final List<String> productionPlaces,
      required final List<String> techniques,
      required final List<String> physicalProperties,
      required final bool hasImage,
      required final bool showImage,
      required final List<String> historicalPersons,
      required final List<String> documentation,
      required final List<ArtDimension> dimensions,
      final String? physicalMedium,
      final ArtImage? webImage,
      required final ArtDating dating,
      required final List<String> inscriptions,
      final String? galleryLocation,
      required final bool onDisplay}) = _$ArtDetailImpl;

  factory _ArtDetail.fromJson(Map<String, dynamic> json) =
      _$ArtDetailImpl.fromJson;

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
  List<String> get inscriptions;
  @override
  String? get galleryLocation;
  @override
  bool get onDisplay;

  /// Create a copy of ArtDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtDetailImplCopyWith<_$ArtDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtColor _$ArtColorFromJson(Map<String, dynamic> json) {
  return _ArtColor.fromJson(json);
}

/// @nodoc
mixin _$ArtColor {
  double get percentage => throw _privateConstructorUsedError;
  String get hex => throw _privateConstructorUsedError;

  /// Serializes this ArtColor to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtColorCopyWith<ArtColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtColorCopyWith<$Res> {
  factory $ArtColorCopyWith(ArtColor value, $Res Function(ArtColor) then) =
      _$ArtColorCopyWithImpl<$Res, ArtColor>;
  @useResult
  $Res call({double percentage, String hex});
}

/// @nodoc
class _$ArtColorCopyWithImpl<$Res, $Val extends ArtColor>
    implements $ArtColorCopyWith<$Res> {
  _$ArtColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? hex = null,
  }) {
    return _then(_value.copyWith(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      hex: null == hex
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtColorImplCopyWith<$Res>
    implements $ArtColorCopyWith<$Res> {
  factory _$$ArtColorImplCopyWith(
          _$ArtColorImpl value, $Res Function(_$ArtColorImpl) then) =
      __$$ArtColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double percentage, String hex});
}

/// @nodoc
class __$$ArtColorImplCopyWithImpl<$Res>
    extends _$ArtColorCopyWithImpl<$Res, _$ArtColorImpl>
    implements _$$ArtColorImplCopyWith<$Res> {
  __$$ArtColorImplCopyWithImpl(
      _$ArtColorImpl _value, $Res Function(_$ArtColorImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtColor
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? percentage = null,
    Object? hex = null,
  }) {
    return _then(_$ArtColorImpl(
      percentage: null == percentage
          ? _value.percentage
          : percentage // ignore: cast_nullable_to_non_nullable
              as double,
      hex: null == hex
          ? _value.hex
          : hex // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtColorImpl implements _ArtColor {
  const _$ArtColorImpl({required this.percentage, required this.hex});

  factory _$ArtColorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtColorImplFromJson(json);

  @override
  final double percentage;
  @override
  final String hex;

  @override
  String toString() {
    return 'ArtColor(percentage: $percentage, hex: $hex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtColorImpl &&
            (identical(other.percentage, percentage) ||
                other.percentage == percentage) &&
            (identical(other.hex, hex) || other.hex == hex));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, percentage, hex);

  /// Create a copy of ArtColor
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtColorImplCopyWith<_$ArtColorImpl> get copyWith =>
      __$$ArtColorImplCopyWithImpl<_$ArtColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtColorImplToJson(
      this,
    );
  }
}

abstract class _ArtColor implements ArtColor {
  const factory _ArtColor(
      {required final double percentage,
      required final String hex}) = _$ArtColorImpl;

  factory _ArtColor.fromJson(Map<String, dynamic> json) =
      _$ArtColorImpl.fromJson;

  @override
  double get percentage;
  @override
  String get hex;

  /// Create a copy of ArtColor
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtColorImplCopyWith<_$ArtColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDating _$ArtDatingFromJson(Map<String, dynamic> json) {
  return _ArtDating.fromJson(json);
}

/// @nodoc
mixin _$ArtDating {
  String get presentingDate => throw _privateConstructorUsedError;
  int get sortingDate => throw _privateConstructorUsedError;
  int get period => throw _privateConstructorUsedError;
  int get yearEarly => throw _privateConstructorUsedError;
  int get yearLate => throw _privateConstructorUsedError;

  /// Serializes this ArtDating to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtDating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtDatingCopyWith<ArtDating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDatingCopyWith<$Res> {
  factory $ArtDatingCopyWith(ArtDating value, $Res Function(ArtDating) then) =
      _$ArtDatingCopyWithImpl<$Res, ArtDating>;
  @useResult
  $Res call(
      {String presentingDate,
      int sortingDate,
      int period,
      int yearEarly,
      int yearLate});
}

/// @nodoc
class _$ArtDatingCopyWithImpl<$Res, $Val extends ArtDating>
    implements $ArtDatingCopyWith<$Res> {
  _$ArtDatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtDating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presentingDate = null,
    Object? sortingDate = null,
    Object? period = null,
    Object? yearEarly = null,
    Object? yearLate = null,
  }) {
    return _then(_value.copyWith(
      presentingDate: null == presentingDate
          ? _value.presentingDate
          : presentingDate // ignore: cast_nullable_to_non_nullable
              as String,
      sortingDate: null == sortingDate
          ? _value.sortingDate
          : sortingDate // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      yearEarly: null == yearEarly
          ? _value.yearEarly
          : yearEarly // ignore: cast_nullable_to_non_nullable
              as int,
      yearLate: null == yearLate
          ? _value.yearLate
          : yearLate // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtDatingImplCopyWith<$Res>
    implements $ArtDatingCopyWith<$Res> {
  factory _$$ArtDatingImplCopyWith(
          _$ArtDatingImpl value, $Res Function(_$ArtDatingImpl) then) =
      __$$ArtDatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String presentingDate,
      int sortingDate,
      int period,
      int yearEarly,
      int yearLate});
}

/// @nodoc
class __$$ArtDatingImplCopyWithImpl<$Res>
    extends _$ArtDatingCopyWithImpl<$Res, _$ArtDatingImpl>
    implements _$$ArtDatingImplCopyWith<$Res> {
  __$$ArtDatingImplCopyWithImpl(
      _$ArtDatingImpl _value, $Res Function(_$ArtDatingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtDating
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? presentingDate = null,
    Object? sortingDate = null,
    Object? period = null,
    Object? yearEarly = null,
    Object? yearLate = null,
  }) {
    return _then(_$ArtDatingImpl(
      presentingDate: null == presentingDate
          ? _value.presentingDate
          : presentingDate // ignore: cast_nullable_to_non_nullable
              as String,
      sortingDate: null == sortingDate
          ? _value.sortingDate
          : sortingDate // ignore: cast_nullable_to_non_nullable
              as int,
      period: null == period
          ? _value.period
          : period // ignore: cast_nullable_to_non_nullable
              as int,
      yearEarly: null == yearEarly
          ? _value.yearEarly
          : yearEarly // ignore: cast_nullable_to_non_nullable
              as int,
      yearLate: null == yearLate
          ? _value.yearLate
          : yearLate // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtDatingImpl implements _ArtDating {
  const _$ArtDatingImpl(
      {required this.presentingDate,
      required this.sortingDate,
      required this.period,
      required this.yearEarly,
      required this.yearLate});

  factory _$ArtDatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtDatingImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtDatingImpl &&
            (identical(other.presentingDate, presentingDate) ||
                other.presentingDate == presentingDate) &&
            (identical(other.sortingDate, sortingDate) ||
                other.sortingDate == sortingDate) &&
            (identical(other.period, period) || other.period == period) &&
            (identical(other.yearEarly, yearEarly) ||
                other.yearEarly == yearEarly) &&
            (identical(other.yearLate, yearLate) ||
                other.yearLate == yearLate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, presentingDate, sortingDate, period, yearEarly, yearLate);

  /// Create a copy of ArtDating
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtDatingImplCopyWith<_$ArtDatingImpl> get copyWith =>
      __$$ArtDatingImplCopyWithImpl<_$ArtDatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtDatingImplToJson(
      this,
    );
  }
}

abstract class _ArtDating implements ArtDating {
  const factory _ArtDating(
      {required final String presentingDate,
      required final int sortingDate,
      required final int period,
      required final int yearEarly,
      required final int yearLate}) = _$ArtDatingImpl;

  factory _ArtDating.fromJson(Map<String, dynamic> json) =
      _$ArtDatingImpl.fromJson;

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

  /// Create a copy of ArtDating
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtDatingImplCopyWith<_$ArtDatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtDimension _$ArtDimensionFromJson(Map<String, dynamic> json) {
  return _ArtDimension.fromJson(json);
}

/// @nodoc
mixin _$ArtDimension {
  String get unit => throw _privateConstructorUsedError;
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(fromJson: stringToDoubleParser)
  double get value => throw _privateConstructorUsedError;
  String? get part => throw _privateConstructorUsedError;

  /// Serializes this ArtDimension to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtDimension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtDimensionCopyWith<ArtDimension> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtDimensionCopyWith<$Res> {
  factory $ArtDimensionCopyWith(
          ArtDimension value, $Res Function(ArtDimension) then) =
      _$ArtDimensionCopyWithImpl<$Res, ArtDimension>;
  @useResult
  $Res call(
      {String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) double value,
      String? part});
}

/// @nodoc
class _$ArtDimensionCopyWithImpl<$Res, $Val extends ArtDimension>
    implements $ArtDimensionCopyWith<$Res> {
  _$ArtDimensionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtDimension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? type = freezed,
    Object? value = null,
    Object? part = freezed,
  }) {
    return _then(_value.copyWith(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtDimensionImplCopyWith<$Res>
    implements $ArtDimensionCopyWith<$Res> {
  factory _$$ArtDimensionImplCopyWith(
          _$ArtDimensionImpl value, $Res Function(_$ArtDimensionImpl) then) =
      __$$ArtDimensionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String unit,
      String? type,
      @JsonKey(fromJson: stringToDoubleParser) double value,
      String? part});
}

/// @nodoc
class __$$ArtDimensionImplCopyWithImpl<$Res>
    extends _$ArtDimensionCopyWithImpl<$Res, _$ArtDimensionImpl>
    implements _$$ArtDimensionImplCopyWith<$Res> {
  __$$ArtDimensionImplCopyWithImpl(
      _$ArtDimensionImpl _value, $Res Function(_$ArtDimensionImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtDimension
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? unit = null,
    Object? type = freezed,
    Object? value = null,
    Object? part = freezed,
  }) {
    return _then(_$ArtDimensionImpl(
      unit: null == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      value: null == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as double,
      part: freezed == part
          ? _value.part
          : part // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtDimensionImpl implements _ArtDimension {
  const _$ArtDimensionImpl(
      {required this.unit,
      this.type,
      @JsonKey(fromJson: stringToDoubleParser) required this.value,
      this.part});

  factory _$ArtDimensionImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtDimensionImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtDimensionImpl &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.part, part) || other.part == part));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, unit, type, value, part);

  /// Create a copy of ArtDimension
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtDimensionImplCopyWith<_$ArtDimensionImpl> get copyWith =>
      __$$ArtDimensionImplCopyWithImpl<_$ArtDimensionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtDimensionImplToJson(
      this,
    );
  }
}

abstract class _ArtDimension implements ArtDimension {
  const factory _ArtDimension(
      {required final String unit,
      final String? type,
      @JsonKey(fromJson: stringToDoubleParser) required final double value,
      final String? part}) = _$ArtDimensionImpl;

  factory _ArtDimension.fromJson(Map<String, dynamic> json) =
      _$ArtDimensionImpl.fromJson;

  @override
  String get unit;
  @override
  String? get type;
  @override
  @JsonKey(fromJson: stringToDoubleParser)
  double get value;
  @override
  String? get part;

  /// Create a copy of ArtDimension
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtDimensionImplCopyWith<_$ArtDimensionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtLabel _$ArtLabelFromJson(Map<String, dynamic> json) {
  return _ArtLabel.fromJson(json);
}

/// @nodoc
mixin _$ArtLabel {
  String? get title => throw _privateConstructorUsedError;
  String? get makerLine => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;

  /// Serializes this ArtLabel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtLabelCopyWith<ArtLabel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtLabelCopyWith<$Res> {
  factory $ArtLabelCopyWith(ArtLabel value, $Res Function(ArtLabel) then) =
      _$ArtLabelCopyWithImpl<$Res, ArtLabel>;
  @useResult
  $Res call(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date});
}

/// @nodoc
class _$ArtLabelCopyWithImpl<$Res, $Val extends ArtLabel>
    implements $ArtLabelCopyWith<$Res> {
  _$ArtLabelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? makerLine = freezed,
    Object? description = freezed,
    Object? notes = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      makerLine: freezed == makerLine
          ? _value.makerLine
          : makerLine // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtLabelImplCopyWith<$Res>
    implements $ArtLabelCopyWith<$Res> {
  factory _$$ArtLabelImplCopyWith(
          _$ArtLabelImpl value, $Res Function(_$ArtLabelImpl) then) =
      __$$ArtLabelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? title,
      String? makerLine,
      String? description,
      String? notes,
      DateTime? date});
}

/// @nodoc
class __$$ArtLabelImplCopyWithImpl<$Res>
    extends _$ArtLabelCopyWithImpl<$Res, _$ArtLabelImpl>
    implements _$$ArtLabelImplCopyWith<$Res> {
  __$$ArtLabelImplCopyWithImpl(
      _$ArtLabelImpl _value, $Res Function(_$ArtLabelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtLabel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = freezed,
    Object? makerLine = freezed,
    Object? description = freezed,
    Object? notes = freezed,
    Object? date = freezed,
  }) {
    return _then(_$ArtLabelImpl(
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      makerLine: freezed == makerLine
          ? _value.makerLine
          : makerLine // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtLabelImpl implements _ArtLabel {
  const _$ArtLabelImpl(
      {this.title, this.makerLine, this.description, this.notes, this.date});

  factory _$ArtLabelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtLabelImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtLabelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.makerLine, makerLine) ||
                other.makerLine == makerLine) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, title, makerLine, description, notes, date);

  /// Create a copy of ArtLabel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtLabelImplCopyWith<_$ArtLabelImpl> get copyWith =>
      __$$ArtLabelImplCopyWithImpl<_$ArtLabelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtLabelImplToJson(
      this,
    );
  }
}

abstract class _ArtLabel implements ArtLabel {
  const factory _ArtLabel(
      {final String? title,
      final String? makerLine,
      final String? description,
      final String? notes,
      final DateTime? date}) = _$ArtLabelImpl;

  factory _ArtLabel.fromJson(Map<String, dynamic> json) =
      _$ArtLabelImpl.fromJson;

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

  /// Create a copy of ArtLabel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtLabelImplCopyWith<_$ArtLabelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtLinks _$ArtLinksFromJson(Map<String, dynamic> json) {
  return _ArtLinks.fromJson(json);
}

/// @nodoc
mixin _$ArtLinks {
  String? get web => throw _privateConstructorUsedError;
  String? get self => throw _privateConstructorUsedError;
  String? get search => throw _privateConstructorUsedError;

  /// Serializes this ArtLinks to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtLinksCopyWith<ArtLinks> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtLinksCopyWith<$Res> {
  factory $ArtLinksCopyWith(ArtLinks value, $Res Function(ArtLinks) then) =
      _$ArtLinksCopyWithImpl<$Res, ArtLinks>;
  @useResult
  $Res call({String? web, String? self, String? search});
}

/// @nodoc
class _$ArtLinksCopyWithImpl<$Res, $Val extends ArtLinks>
    implements $ArtLinksCopyWith<$Res> {
  _$ArtLinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? web = freezed,
    Object? self = freezed,
    Object? search = freezed,
  }) {
    return _then(_value.copyWith(
      web: freezed == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String?,
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtLinksImplCopyWith<$Res>
    implements $ArtLinksCopyWith<$Res> {
  factory _$$ArtLinksImplCopyWith(
          _$ArtLinksImpl value, $Res Function(_$ArtLinksImpl) then) =
      __$$ArtLinksImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? web, String? self, String? search});
}

/// @nodoc
class __$$ArtLinksImplCopyWithImpl<$Res>
    extends _$ArtLinksCopyWithImpl<$Res, _$ArtLinksImpl>
    implements _$$ArtLinksImplCopyWith<$Res> {
  __$$ArtLinksImplCopyWithImpl(
      _$ArtLinksImpl _value, $Res Function(_$ArtLinksImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtLinks
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? web = freezed,
    Object? self = freezed,
    Object? search = freezed,
  }) {
    return _then(_$ArtLinksImpl(
      web: freezed == web
          ? _value.web
          : web // ignore: cast_nullable_to_non_nullable
              as String?,
      self: freezed == self
          ? _value.self
          : self // ignore: cast_nullable_to_non_nullable
              as String?,
      search: freezed == search
          ? _value.search
          : search // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtLinksImpl implements _ArtLinks {
  const _$ArtLinksImpl({this.web, this.self, this.search});

  factory _$ArtLinksImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtLinksImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtLinksImpl &&
            (identical(other.web, web) || other.web == web) &&
            (identical(other.self, self) || other.self == self) &&
            (identical(other.search, search) || other.search == search));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, web, self, search);

  /// Create a copy of ArtLinks
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtLinksImplCopyWith<_$ArtLinksImpl> get copyWith =>
      __$$ArtLinksImplCopyWithImpl<_$ArtLinksImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtLinksImplToJson(
      this,
    );
  }
}

abstract class _ArtLinks implements ArtLinks {
  const factory _ArtLinks(
      {final String? web,
      final String? self,
      final String? search}) = _$ArtLinksImpl;

  factory _ArtLinks.fromJson(Map<String, dynamic> json) =
      _$ArtLinksImpl.fromJson;

  @override
  String? get web;
  @override
  String? get self;
  @override
  String? get search;

  /// Create a copy of ArtLinks
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtLinksImplCopyWith<_$ArtLinksImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtMaker _$ArtMakerFromJson(Map<String, dynamic> json) {
  return _ArtMaker.fromJson(json);
}

/// @nodoc
mixin _$ArtMaker {
  String? get id => throw _privateConstructorUsedError;
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

  /// Serializes this ArtMaker to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtMaker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtMakerCopyWith<ArtMaker> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtMakerCopyWith<$Res> {
  factory $ArtMakerCopyWith(ArtMaker value, $Res Function(ArtMaker) then) =
      _$ArtMakerCopyWithImpl<$Res, ArtMaker>;
  @useResult
  $Res call(
      {String? id,
      String name,
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
class _$ArtMakerCopyWithImpl<$Res, $Val extends ArtMaker>
    implements $ArtMakerCopyWith<$Res> {
  _$ArtMakerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtMaker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? unFixedName = null,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? dateOfDeath = freezed,
    Object? placeOfDeath = freezed,
    Object? occupation = null,
    Object? roles = null,
    Object? nationality = freezed,
    Object? biography = freezed,
    Object? labelDesc = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unFixedName: null == unFixedName
          ? _value.unFixedName
          : unFixedName // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfDeath: freezed == dateOfDeath
          ? _value.dateOfDeath
          : dateOfDeath // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfDeath: freezed == placeOfDeath
          ? _value.placeOfDeath
          : placeOfDeath // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: null == occupation
          ? _value.occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: freezed == biography
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String?,
      labelDesc: null == labelDesc
          ? _value.labelDesc
          : labelDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtMakerImplCopyWith<$Res>
    implements $ArtMakerCopyWith<$Res> {
  factory _$$ArtMakerImplCopyWith(
          _$ArtMakerImpl value, $Res Function(_$ArtMakerImpl) then) =
      __$$ArtMakerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String name,
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
class __$$ArtMakerImplCopyWithImpl<$Res>
    extends _$ArtMakerCopyWithImpl<$Res, _$ArtMakerImpl>
    implements _$$ArtMakerImplCopyWith<$Res> {
  __$$ArtMakerImplCopyWithImpl(
      _$ArtMakerImpl _value, $Res Function(_$ArtMakerImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtMaker
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = null,
    Object? unFixedName = null,
    Object? placeOfBirth = freezed,
    Object? dateOfBirth = freezed,
    Object? dateOfDeath = freezed,
    Object? placeOfDeath = freezed,
    Object? occupation = null,
    Object? roles = null,
    Object? nationality = freezed,
    Object? biography = freezed,
    Object? labelDesc = null,
  }) {
    return _then(_$ArtMakerImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      unFixedName: null == unFixedName
          ? _value.unFixedName
          : unFixedName // ignore: cast_nullable_to_non_nullable
              as String,
      placeOfBirth: freezed == placeOfBirth
          ? _value.placeOfBirth
          : placeOfBirth // ignore: cast_nullable_to_non_nullable
              as String?,
      dateOfBirth: freezed == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateOfDeath: freezed == dateOfDeath
          ? _value.dateOfDeath
          : dateOfDeath // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      placeOfDeath: freezed == placeOfDeath
          ? _value.placeOfDeath
          : placeOfDeath // ignore: cast_nullable_to_non_nullable
              as String?,
      occupation: null == occupation
          ? _value._occupation
          : occupation // ignore: cast_nullable_to_non_nullable
              as List<String>,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      nationality: freezed == nationality
          ? _value.nationality
          : nationality // ignore: cast_nullable_to_non_nullable
              as String?,
      biography: freezed == biography
          ? _value.biography
          : biography // ignore: cast_nullable_to_non_nullable
              as String?,
      labelDesc: null == labelDesc
          ? _value.labelDesc
          : labelDesc // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtMakerImpl implements _ArtMaker {
  const _$ArtMakerImpl(
      {this.id,
      required this.name,
      required this.unFixedName,
      this.placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) this.dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser) this.dateOfDeath,
      this.placeOfDeath,
      required final List<String> occupation,
      required final List<String> roles,
      this.nationality,
      this.biography,
      required this.labelDesc})
      : _occupation = occupation,
        _roles = roles;

  factory _$ArtMakerImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtMakerImplFromJson(json);

  @override
  final String? id;
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
  final List<String> _occupation;
  @override
  List<String> get occupation {
    if (_occupation is EqualUnmodifiableListView) return _occupation;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_occupation);
  }

  final List<String> _roles;
  @override
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  final String? nationality;
  @override
  final String? biography;
  @override
  final String labelDesc;

  @override
  String toString() {
    return 'ArtMaker(id: $id, name: $name, unFixedName: $unFixedName, placeOfBirth: $placeOfBirth, dateOfBirth: $dateOfBirth, dateOfDeath: $dateOfDeath, placeOfDeath: $placeOfDeath, occupation: $occupation, roles: $roles, nationality: $nationality, biography: $biography, labelDesc: $labelDesc)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtMakerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unFixedName, unFixedName) ||
                other.unFixedName == unFixedName) &&
            (identical(other.placeOfBirth, placeOfBirth) ||
                other.placeOfBirth == placeOfBirth) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.dateOfDeath, dateOfDeath) ||
                other.dateOfDeath == dateOfDeath) &&
            (identical(other.placeOfDeath, placeOfDeath) ||
                other.placeOfDeath == placeOfDeath) &&
            const DeepCollectionEquality()
                .equals(other._occupation, _occupation) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.nationality, nationality) ||
                other.nationality == nationality) &&
            (identical(other.biography, biography) ||
                other.biography == biography) &&
            (identical(other.labelDesc, labelDesc) ||
                other.labelDesc == labelDesc));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      unFixedName,
      placeOfBirth,
      dateOfBirth,
      dateOfDeath,
      placeOfDeath,
      const DeepCollectionEquality().hash(_occupation),
      const DeepCollectionEquality().hash(_roles),
      nationality,
      biography,
      labelDesc);

  /// Create a copy of ArtMaker
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtMakerImplCopyWith<_$ArtMakerImpl> get copyWith =>
      __$$ArtMakerImplCopyWithImpl<_$ArtMakerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtMakerImplToJson(
      this,
    );
  }
}

abstract class _ArtMaker implements ArtMaker {
  const factory _ArtMaker(
      {final String? id,
      required final String name,
      required final String unFixedName,
      final String? placeOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser)
      final DateTime? dateOfBirth,
      @JsonKey(fromJson: stringToDateNullableParser)
      final DateTime? dateOfDeath,
      final String? placeOfDeath,
      required final List<String> occupation,
      required final List<String> roles,
      final String? nationality,
      final String? biography,
      required final String labelDesc}) = _$ArtMakerImpl;

  factory _ArtMaker.fromJson(Map<String, dynamic> json) =
      _$ArtMakerImpl.fromJson;

  @override
  String? get id;
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

  /// Create a copy of ArtMaker
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtMakerImplCopyWith<_$ArtMakerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArtImage _$ArtImageFromJson(Map<String, dynamic> json) {
  return _ArtImage.fromJson(json);
}

/// @nodoc
mixin _$ArtImage {
  String? get guid => throw _privateConstructorUsedError;
  int get width => throw _privateConstructorUsedError;
  int get height => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  /// Serializes this ArtImage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ArtImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ArtImageCopyWith<ArtImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArtImageCopyWith<$Res> {
  factory $ArtImageCopyWith(ArtImage value, $Res Function(ArtImage) then) =
      _$ArtImageCopyWithImpl<$Res, ArtImage>;
  @useResult
  $Res call({String? guid, int width, int height, String? url});
}

/// @nodoc
class _$ArtImageCopyWithImpl<$Res, $Val extends ArtImage>
    implements $ArtImageCopyWith<$Res> {
  _$ArtImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ArtImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guid = freezed,
    Object? width = null,
    Object? height = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      guid: freezed == guid
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArtImageImplCopyWith<$Res>
    implements $ArtImageCopyWith<$Res> {
  factory _$$ArtImageImplCopyWith(
          _$ArtImageImpl value, $Res Function(_$ArtImageImpl) then) =
      __$$ArtImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? guid, int width, int height, String? url});
}

/// @nodoc
class __$$ArtImageImplCopyWithImpl<$Res>
    extends _$ArtImageCopyWithImpl<$Res, _$ArtImageImpl>
    implements _$$ArtImageImplCopyWith<$Res> {
  __$$ArtImageImplCopyWithImpl(
      _$ArtImageImpl _value, $Res Function(_$ArtImageImpl) _then)
      : super(_value, _then);

  /// Create a copy of ArtImage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? guid = freezed,
    Object? width = null,
    Object? height = null,
    Object? url = freezed,
  }) {
    return _then(_$ArtImageImpl(
      guid: freezed == guid
          ? _value.guid
          : guid // ignore: cast_nullable_to_non_nullable
              as String?,
      width: null == width
          ? _value.width
          : width // ignore: cast_nullable_to_non_nullable
              as int,
      height: null == height
          ? _value.height
          : height // ignore: cast_nullable_to_non_nullable
              as int,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArtImageImpl implements _ArtImage {
  const _$ArtImageImpl(
      {this.guid, required this.width, required this.height, this.url});

  factory _$ArtImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArtImageImplFromJson(json);

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
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArtImageImpl &&
            (identical(other.guid, guid) || other.guid == guid) &&
            (identical(other.width, width) || other.width == width) &&
            (identical(other.height, height) || other.height == height) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, guid, width, height, url);

  /// Create a copy of ArtImage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ArtImageImplCopyWith<_$ArtImageImpl> get copyWith =>
      __$$ArtImageImplCopyWithImpl<_$ArtImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArtImageImplToJson(
      this,
    );
  }
}

abstract class _ArtImage implements ArtImage {
  const factory _ArtImage(
      {final String? guid,
      required final int width,
      required final int height,
      final String? url}) = _$ArtImageImpl;

  factory _ArtImage.fromJson(Map<String, dynamic> json) =
      _$ArtImageImpl.fromJson;

  @override
  String? get guid;
  @override
  int get width;
  @override
  int get height;
  @override
  String? get url;

  /// Create a copy of ArtImage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ArtImageImplCopyWith<_$ArtImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
