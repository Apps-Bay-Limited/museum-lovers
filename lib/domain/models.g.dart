// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Art _$$_ArtFromJson(Map<String, dynamic> json) => _$_Art(
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

Map<String, dynamic> _$$_ArtToJson(_$_Art instance) => <String, dynamic>{
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

_$_ArtDetail _$$_ArtDetailFromJson(Map<String, dynamic> json) => _$_ArtDetail(
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
    );

Map<String, dynamic> _$$_ArtDetailToJson(_$_ArtDetail instance) =>
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
    };

_$_ArtColor _$$_ArtColorFromJson(Map<String, dynamic> json) => _$_ArtColor(
      percentage: (json['percentage'] as num).toDouble(),
      hex: json['hex'] as String,
    );

Map<String, dynamic> _$$_ArtColorToJson(_$_ArtColor instance) =>
    <String, dynamic>{
      'percentage': instance.percentage,
      'hex': instance.hex,
    };

_$_ArtDating _$$_ArtDatingFromJson(Map<String, dynamic> json) => _$_ArtDating(
      presentingDate: json['presentingDate'] as String,
      sortingDate: json['sortingDate'] as int,
      period: json['period'] as int,
      yearEarly: json['yearEarly'] as int,
      yearLate: json['yearLate'] as int,
    );

Map<String, dynamic> _$$_ArtDatingToJson(_$_ArtDating instance) =>
    <String, dynamic>{
      'presentingDate': instance.presentingDate,
      'sortingDate': instance.sortingDate,
      'period': instance.period,
      'yearEarly': instance.yearEarly,
      'yearLate': instance.yearLate,
    };

_$_ArtDimension _$$_ArtDimensionFromJson(Map<String, dynamic> json) =>
    _$_ArtDimension(
      unit: json['unit'] as String,
      type: json['type'] as String?,
      value: stringToDoubleParser(json['value'] as String),
      part: json['part'] as String?,
    );

Map<String, dynamic> _$$_ArtDimensionToJson(_$_ArtDimension instance) =>
    <String, dynamic>{
      'unit': instance.unit,
      'type': instance.type,
      'value': instance.value,
      'part': instance.part,
    };

_$_ArtLabel _$$_ArtLabelFromJson(Map<String, dynamic> json) => _$_ArtLabel(
      title: json['title'] as String?,
      makerLine: json['makerLine'] as String?,
      description: json['description'] as String?,
      notes: json['notes'] as String?,
      date:
          json['date'] == null ? null : DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$_ArtLabelToJson(_$_ArtLabel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'makerLine': instance.makerLine,
      'description': instance.description,
      'notes': instance.notes,
      'date': instance.date?.toIso8601String(),
    };

_$_ArtLinks _$$_ArtLinksFromJson(Map<String, dynamic> json) => _$_ArtLinks(
      web: json['web'] as String?,
      self: json['self'] as String?,
      search: json['search'] as String?,
    );

Map<String, dynamic> _$$_ArtLinksToJson(_$_ArtLinks instance) =>
    <String, dynamic>{
      'web': instance.web,
      'self': instance.self,
      'search': instance.search,
    };

_$_ArtMaker _$$_ArtMakerFromJson(Map<String, dynamic> json) => _$_ArtMaker(
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

Map<String, dynamic> _$$_ArtMakerToJson(_$_ArtMaker instance) =>
    <String, dynamic>{
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

_$_ArtImage _$$_ArtImageFromJson(Map<String, dynamic> json) => _$_ArtImage(
      guid: json['guid'] as String?,
      width: json['width'] as int,
      height: json['height'] as int,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$$_ArtImageToJson(_$_ArtImage instance) =>
    <String, dynamic>{
      'guid': instance.guid,
      'width': instance.width,
      'height': instance.height,
      'url': instance.url,
    };
