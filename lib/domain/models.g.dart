// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArtImpl _$$ArtImplFromJson(Map<String, dynamic> json) => _$ArtImpl(
      id: json['id'] as String,
      objectNumber: json['objectNumber'] as String,
      title: json['title'] as String,
      longTitle: json['longTitle'] as String,
      principalOrFirstMaker: json['principalOrFirstMaker'] as String,
      hasImage: json['hasImage'] as bool,
      showImage: json['showImage'] as bool,
      webImage: json['webImage'] == null
          ? null
          : ArtImage.fromJson(json['webImage'] as Map<String, dynamic>),
      headerImage: json['headerImage'] == null
          ? null
          : ArtImage.fromJson(json['headerImage'] as Map<String, dynamic>),
      links: ArtLinks.fromJson(json['links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$ArtImplToJson(_$ArtImpl instance) => <String, dynamic>{
      'id': instance.id,
      'objectNumber': instance.objectNumber,
      'title': instance.title,
      'longTitle': instance.longTitle,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'hasImage': instance.hasImage,
      'showImage': instance.showImage,
      'webImage': instance.webImage,
      'headerImage': instance.headerImage,
      'links': instance.links,
    };

_$ArtDetailImpl _$$ArtDetailImplFromJson(Map<String, dynamic> json) =>
    _$ArtDetailImpl(
      id: json['id'] as String,
      objectNumber: json['objectNumber'] as String,
      colors: (json['colors'] as List<dynamic>)
          .map((e) => ArtColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      normalizedColors: (json['normalizedColors'] as List<dynamic>)
          .map((e) => ArtColor.fromJson(e as Map<String, dynamic>))
          .toList(),
      title: json['title'] as String,
      titles:
          (json['titles'] as List<dynamic>).map((e) => e as String).toList(),
      longTitle: json['longTitle'] as String,
      subTitle: json['subTitle'] as String,
      scLabelLine: json['scLabelLine'] as String,
      label: ArtLabel.fromJson(json['label'] as Map<String, dynamic>),
      description: json['description'] as String?,
      objectTypes: (json['objectTypes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      objectCollection: (json['objectCollection'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      principalMaker: json['principalMaker'] as String,
      principalOrFirstMaker: json['principalOrFirstMaker'] as String,
      principalMakers: (json['principalMakers'] as List<dynamic>)
          .map((e) => ArtMaker.fromJson(e as Map<String, dynamic>))
          .toList(),
      plaqueDescriptionEnglish: json['plaqueDescriptionEnglish'] as String?,
      materials:
          (json['materials'] as List<dynamic>).map((e) => e as String).toList(),
      productionPlaces: (json['productionPlaces'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      techniques: (json['techniques'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      physicalProperties: (json['physicalProperties'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      hasImage: json['hasImage'] as bool,
      showImage: json['showImage'] as bool,
      historicalPersons: (json['historicalPersons'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      documentation: (json['documentation'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      dimensions: (json['dimensions'] as List<dynamic>)
          .map((e) => ArtDimension.fromJson(e as Map<String, dynamic>))
          .toList(),
      physicalMedium: json['physicalMedium'] as String?,
      webImage: json['webImage'] == null
          ? null
          : ArtImage.fromJson(json['webImage'] as Map<String, dynamic>),
      dating: ArtDating.fromJson(json['dating'] as Map<String, dynamic>),
      inscriptions: (json['inscriptions'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      galleryLocation: json['galleryLocation'] as String?,
      onDisplay: json['onDisplay'] as bool,
    );

Map<String, dynamic> _$$ArtDetailImplToJson(_$ArtDetailImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'objectNumber': instance.objectNumber,
      'colors': instance.colors,
      'normalizedColors': instance.normalizedColors,
      'title': instance.title,
      'titles': instance.titles,
      'longTitle': instance.longTitle,
      'subTitle': instance.subTitle,
      'scLabelLine': instance.scLabelLine,
      'label': instance.label,
      'description': instance.description,
      'objectTypes': instance.objectTypes,
      'objectCollection': instance.objectCollection,
      'principalMaker': instance.principalMaker,
      'principalOrFirstMaker': instance.principalOrFirstMaker,
      'principalMakers': instance.principalMakers,
      'plaqueDescriptionEnglish': instance.plaqueDescriptionEnglish,
      'materials': instance.materials,
      'productionPlaces': instance.productionPlaces,
      'techniques': instance.techniques,
      'physicalProperties': instance.physicalProperties,
      'hasImage': instance.hasImage,
      'showImage': instance.showImage,
      'historicalPersons': instance.historicalPersons,
      'documentation': instance.documentation,
      'dimensions': instance.dimensions,
      'physicalMedium': instance.physicalMedium,
      'webImage': instance.webImage,
      'dating': instance.dating,
      'inscriptions': instance.inscriptions,
      'galleryLocation': instance.galleryLocation,
      'onDisplay': instance.onDisplay,
    };

_$ArtColorImpl _$$ArtColorImplFromJson(Map<String, dynamic> json) =>
    _$ArtColorImpl(
      percentage: (json['percentage'] as num).toDouble(),
      hex: json['hex'] as String,
    );

Map<String, dynamic> _$$ArtColorImplToJson(_$ArtColorImpl instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'hex': instance.hex,
    };

_$ArtDatingImpl _$$ArtDatingImplFromJson(Map<String, dynamic> json) =>
    _$ArtDatingImpl(
      presentingDate: json['presentingDate'] as String,
      sortingDate: (json['sortingDate'] as num).toInt(),
      period: (json['period'] as num).toInt(),
      yearEarly: (json['yearEarly'] as num).toInt(),
      yearLate: (json['yearLate'] as num).toInt(),
    );

Map<String, dynamic> _$$ArtDatingImplToJson(_$ArtDatingImpl instance) =>
    <String, dynamic>{
      'presentingDate': instance.presentingDate,
      'sortingDate': instance.sortingDate,
      'period': instance.period,
      'yearEarly': instance.yearEarly,
      'yearLate': instance.yearLate,
    };

_$ArtDimensionImpl _$$ArtDimensionImplFromJson(Map<String, dynamic> json) =>
    _$ArtDimensionImpl(
      unit: json['unit'] as String,
      type: json['type'] as String?,
      value: stringToDoubleParser(json['value'] as String),
      part: json['part'] as String?,
    );

Map<String, dynamic> _$$ArtDimensionImplToJson(_$ArtDimensionImpl instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'type': instance.type,
      'value': instance.value,
      'part': instance.part,
    };

_$ArtLabelImpl _$$ArtLabelImplFromJson(Map<String, dynamic> json) =>
    _$ArtLabelImpl(
      title: json['title'] as String?,
      makerLine: json['makerLine'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$ArtLabelImplToJson(_$ArtLabelImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'makerLine': instance.makerLine,
      'description': instance.description,
      'notes': instance.notes,
      'date': instance.date?.toIso8601String(),
    };

_$ArtLinksImpl _$$ArtLinksImplFromJson(Map<String, dynamic> json) =>
    _$ArtLinksImpl(
      web: json['web'] as String?,
      self: json['self'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$$ArtLinksImplToJson(_$ArtLinksImpl instance) =>
    <String, dynamic>{
      'web': instance.web,
      'self': instance.self,
      'search': instance.search,
    };

_$ArtMakerImpl _$$ArtMakerImplFromJson(Map<String, dynamic> json) =>
    _$ArtMakerImpl(
      id: json['id'] as String?,
      name: json['name'] as String,
      unFixedName: json['unFixedName'] as String,
      placeOfBirth: json['placeOfBirth'] as String?,
      dateOfBirth: stringToDateNullableParser(json['dateOfBirth'] as String?),
      dateOfDeath: stringToDateNullableParser(json['dateOfDeath'] as String?),
      placeOfDeath: json['placeOfDeath'] as String?,
      occupation: (json['occupation'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      roles: (json['roles'] as List<dynamic>).map((e) => e as String).toList(),
      nationality: json['nationality'] as String?,
      biography: json['biography'] as String?,
      labelDesc: json['labelDesc'] as String,
    );

Map<String, dynamic> _$$ArtMakerImplToJson(_$ArtMakerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'unFixedName': instance.unFixedName,
      'placeOfBirth': instance.placeOfBirth,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'dateOfDeath': instance.dateOfDeath?.toIso8601String(),
      'placeOfDeath': instance.placeOfDeath,
      'occupation': instance.occupation,
      'roles': instance.roles,
      'nationality': instance.nationality,
      'biography': instance.biography,
      'labelDesc': instance.labelDesc,
    };

_$ArtImageImpl _$$ArtImageImplFromJson(Map<String, dynamic> json) =>
    _$ArtImageImpl(
      guid: json['guid'] as String?,
      width: (json['width'] as num).toInt(),
      height: (json['height'] as num).toInt(),
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$ArtImageImplToJson(_$ArtImageImpl instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };
