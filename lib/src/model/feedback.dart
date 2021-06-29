import 'package:flutter/foundation.dart';

@immutable
class UserFeedback {
  final int? rating;
  final String? review;
  final DateTime? createdAt;

  UserFeedback({this.rating, this.review, this.createdAt});

  factory UserFeedback.fromJson(Map<String, dynamic> map) {
    return UserFeedback(
        rating: map["rating"] != null ? map["rating"] : null,
        // createdAt: map["createdAt"] != null ? map["createdAt"] : null,
        review: map["review"] != null ? map["review"] : null,
        createdAt: map['createdAt'] != null
            ? DateTime.parse(map['createdAt'] as String)
            : null);
  }
  Map<String, dynamic> toJson() {
    return {
      "rating": rating,
      "createdAt": createdAt?.toIso8601String(),
      "review": review
    };
  }

  UserFeedback copyWith({int? rating, String? review, DateTime? createdAt}) {
    return UserFeedback(
      rating: rating ?? this.rating,
      createdAt: createdAt ?? this.createdAt,
      review: review ?? this.review,
    );
  }

  @override
  String toString() => "{rating:$rating, createdAt:$createdAt, review:$review}";
}
