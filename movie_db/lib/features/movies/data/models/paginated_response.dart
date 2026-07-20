class PaginatedResponse<T> {
  final int page;
  final List<T> results;
  final int totalPages;
  final int totalResults;

  const PaginatedResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory PaginatedResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic>) fromJsonT,
  ) {
    final rawResults = json['results'] as List<dynamic>? ?? [];
    return PaginatedResponse(
      page: json['page'] as int? ?? 1,
      results: rawResults
          .map((item) => fromJsonT(item as Map<String, dynamic>))
          .toList(),
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
    );
  }
}
