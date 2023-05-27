class ForecastModel {
  List<MyList>? list;

  ForecastModel({this.list});

  ForecastModel.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <MyList>[];
      json['list'].forEach((v) {
        list!.add(new MyList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class MyList {
  Main? main;
  List<Weather>? weather;
  String? dtTxt;

  MyList({this.main, this.weather, this.dtTxt});

  MyList.fromJson(Map<String, dynamic> json) {
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    if (json['weather'] != null) {
      weather = <Weather>[];
      json['weather'].forEach((v) {
        weather!.add(new Weather.fromJson(v));
      });
    }

    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }

    data['dt_txt'] = this.dtTxt;
    return data;
  }
}

class Main {
  double? temp;

  Main({
    this.temp,
  });

  Main.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['temp'] = this.temp;
    return data;
  }
}

class Weather {
  String? icon;

  Weather({this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['icon'] = this.icon;
    return data;
  }
}
