// To parse this JSON data, do
//
//     final locationModel = locationModelFromJson(jsonString);

import 'dart:convert';

class LocationModel {
    LocationModel({
        this.info,
        this.results,
    });

    Info? info;
    List<LocationResult>? results;

    factory LocationModel.fromRawJson(String str) => LocationModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        info: json["info"] == null ? null : Info.fromJson(json["info"]),
        results: json["results"] == null ? [] : List<LocationResult>.from(json["results"]!.map((x) => LocationResult.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "info": info?.toJson(),
        "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    };
}

class Info {
    Info({
        this.count,
        this.pages,
        this.next,
        this.prev,
    });

    int? count;
    int? pages;
    String? next;
    dynamic prev;

    factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}

class LocationResult {
    LocationResult({
        this.id,
        this.name,
        this.type,
        this.dimension,
        this.residents,
        this.url,
        this.created,
    });

    int? id;
    String? name;
    String? type;
    String? dimension;
    List<String>? residents;
    String? url;
    DateTime? created;

    factory LocationResult.fromRawJson(String str) => LocationResult.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationResult.fromJson(Map<String, dynamic> json) => LocationResult(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: json["residents"] == null ? [] : List<String>.from(json["residents"]!.map((x) => x)),
        url: json["url"],
        created: json["created"] == null ? null : DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": residents == null ? [] : List<dynamic>.from(residents!.map((x) => x)),
        "url": url,
        "created": created?.toIso8601String(),
    };
}
