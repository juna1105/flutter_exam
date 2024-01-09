class WebtoonModel {
  late String title, thumb, id;
  // WebtoonModel(Map<String, dynamic> webtoons) {
  //   {
  //     this.title = webtoons['title'];
  //     this.thumb = webtoons['thumb'];
  //     this.id = webtoons['id'];
  //   }
  // }
  WebtoonModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        thumb = json['thumb'],
        id = json['id'];
}
