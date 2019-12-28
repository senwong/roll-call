class Pagination {
  int current;
  int total;
  int pageSize;
  bool hasNextPage;
  Pagination({
    this.current,
    this.total,
    this.pageSize,
    this.hasNextPage,
  });

  Pagination.fromJson(Map<String, dynamic> json)
      : current = json['pageNo'],
        total = json['total'],
        pageSize = json['pageSize'],
        hasNextPage = json['hasNextPage'];

  Map<String, dynamic> toJson() => {
        'current': current,
        'total': total,
        'pageSize': pageSize,
        'hasNextPage': hasNextPage,
      };
}
