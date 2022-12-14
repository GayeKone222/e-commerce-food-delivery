import 'package:e_commerce/core/Routes/routing_data.dart';

extension StringExtenxions on String {
  RoutingData get getRoutingdata {
    var uriData = Uri.parse(this);
  
    return RoutingData(
        queryParameters: uriData.queryParameters, route: uriData.path);
  }
}
