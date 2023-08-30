class Presses_ {
  int? id;
  String? date;
  String? dateGmt;
  Guid? title;
  Content? content;
  Content? excerpt;
  Embedded? eEmbedded;

  Presses_({
    this.id,
    this.date,
    this.dateGmt,
    this.title,
    this.content,
    this.excerpt,
    this.eEmbedded,
  });

  Presses_.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    dateGmt = json['date_gmt'];
    title = json['title'] != null ? new Guid.fromJson(json['title']) : null;
    content =
        json['content'] != null ? new Content.fromJson(json['content']) : null;
    excerpt =
        json['excerpt'] != null ? new Content.fromJson(json['excerpt']) : null;
    eEmbedded = json['_embedded'] != null
        ? new Embedded.fromJson(json['_embedded'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['date'] = date;
    data['date_gmt'] = dateGmt;
    if (title != null) {
      data['title'] = title!.toJson();
    }
    if (content != null) {
      data['content'] = content!.toJson();
    }
    if (excerpt != null) {
      data['excerpt'] = excerpt!.toJson();
    }
    if (eEmbedded != null) {
      data['_embedded'] = eEmbedded!.toJson();
    }
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = rendered;
    return data;
  }
}

class Content {
  String? rendered;
  bool? protected;

  Content({this.rendered, this.protected});

  Content.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
    protected = json['protected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = rendered;
    data['protected'] = protected;
    return data;
  }
}

class Embedded {
  List<WpFeaturedmedia>? wpFeaturedmedia;

  Embedded({
    this.wpFeaturedmedia,
  });

  Embedded.fromJson(Map<String, dynamic> json) {
    if (json['wp:featuredmedia'] != null) {
      wpFeaturedmedia = <WpFeaturedmedia>[];
      json['wp:featuredmedia'].forEach((v) {
        wpFeaturedmedia!.add(new WpFeaturedmedia.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (wpFeaturedmedia != null) {
      data['wp:featuredmedia'] =
          wpFeaturedmedia!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WpFeaturedmedia {
  String? sourceUrl;

  WpFeaturedmedia({
    this.sourceUrl,
  });

  WpFeaturedmedia.fromJson(Map<String, dynamic> json) {
    sourceUrl = json['source_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['source_url'] = sourceUrl;
    return data;
  }
}
