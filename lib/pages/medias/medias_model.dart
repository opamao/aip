class Medias {
  int? id;
  String? date;
  String? dateGmt;
  Guid? guid;
  String? link;
  Guid? title;
  int? author;
  Guid? description;
  Guid? caption;
  String? sourceUrl;

  Medias({
    this.id,
    this.date,
    this.dateGmt,
    this.guid,
    this.link,
    this.title,
    this.author,
    this.description,
    this.caption,
    this.sourceUrl,
  });

  Medias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    guid = json['guid'] != null ? Guid.fromJson(json['guid']) : null;
    link = json['link'];
    title = json['title'] != null ? Guid.fromJson(json['title']) : null;
    author = json['author'];
    description =
        json['description'] != null ? Guid.fromJson(json['description']) : null;
    caption = json['caption'] != null ? Guid.fromJson(json['caption']) : null;
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['date'] = date;
    data['date_gmt'] = dateGmt;
    if (guid != null) {
      data['guid'] = guid!.toJson();
    }
    data['link'] = link;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    data['author'] = author;
    if (description != null) {
      data['description'] = description!.toJson();
    }
    if (caption != null) {
      data['caption'] = caption!.toJson();
    }
    data['source_url'] = sourceUrl;
    return data;
  }
}

class Guid {
  String? rendered;

  Guid({this.rendered});

  Guid.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['rendered'] = rendered;
    return data;
  }
}
