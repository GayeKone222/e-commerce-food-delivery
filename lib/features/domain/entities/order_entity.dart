import 'package:e_commerce/features/data/models/address_model.dart';
import 'package:equatable/equatable.dart';

class OrderModel extends Equatable {
  final int? id;
  final int? userId;
  final double? orderAmount;
  final String? orderStatus;

  final String? paymentStatus;
  final double? totalTaxAmount;
  final String? orderNote;
  final String? createdAt;
  final String? updatedAt;
  final double? deliveryCharge;
  final String? scheduleAt;
  final String? otp;
  final String? pending;
  final String? accepted;
  final String? confirmed;
  final String? processing;
  final String? handover;
  final String? pickedUp;
  final String? delivered;
  final String? canceled;
  final String? refundRequested;
  final String? refunded;
  final int? scheduled;
  final String? failed;
  final int? detailsCount;

  final AddressModel? deliveryAddress;

  const OrderModel({
    required this.id,
    required this.userId,
    this.totalTaxAmount,
    this.refundRequested,
    this.refunded,
    this.orderAmount,
    this.paymentStatus,
    this.orderNote,
    this.createdAt,
    this.updatedAt,
    this.deliveryCharge,
    this.scheduleAt,
    this.otp,
    this.orderStatus,
    this.pending,
    this.accepted,
    this.confirmed,
    this.processing,
    this.handover,
    this.pickedUp,
    this.delivered,
    this.canceled,
    this.scheduled,
    this.failed,
    this.detailsCount,
    this.deliveryAddress,
  });

  @override
  List<Object?> get props => [
        id,
        userId,
        totalTaxAmount,
        refundRequested,
        refunded,
        orderAmount,
        paymentStatus,
        orderNote,
        createdAt,
        updatedAt,
        deliveryCharge,
        scheduleAt,
        otp,
        orderStatus,
        pending,
        accepted,
        confirmed,
        processing,
        handover,
        pickedUp,
        delivered,
        canceled,
        scheduled,
        failed,
        detailsCount,
        deliveryAddress,
      ];

  OrderModel copyWith(
      {int? id,
      int? userId,
      double? orderAmount,
      String? orderStatus,
      String? paymentStatus,
      double? totalTaxAmount,
      String? orderNote,
      String? createdAt,
      String? updatedAt,
      double? deliveryCharge,
      String? scheduleAt,
      String? otp,
      String? pending,
      String? accepted,
      String? confirmed,
      String? processing,
      String? handover,
      String? pickedUp,
      String? delivered,
      String? canceled,
      String? refundRequested,
      String? refunded,
      int? scheduled,
      String? failed,
      int? detailsCount,
      AddressModel? deliveryAddress}) {
    return OrderModel(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        orderAmount: orderAmount ?? this.orderAmount,
        orderStatus: orderStatus ?? this.orderStatus,
        paymentStatus: paymentStatus ?? this.paymentStatus,
        totalTaxAmount: totalTaxAmount ?? this.totalTaxAmount,
        orderNote: orderNote ?? this.orderNote,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deliveryCharge: deliveryCharge ?? this.deliveryCharge,
        scheduleAt: scheduleAt ?? this.scheduleAt,
        otp: otp ?? this.otp,
        pending: pending ?? this.pending,
        accepted: accepted ?? this.accepted,
        confirmed: confirmed ?? this.confirmed,
        processing: processing ?? this.processing,
        handover: handover ?? this.handover,
        pickedUp: pickedUp ?? this.pickedUp,
        delivered: delivered ?? this.delivered,
        canceled: canceled ?? this.canceled,
        refundRequested: refundRequested ?? this.refundRequested,
        refunded: refunded ?? this.refunded,
        scheduled: scheduled ?? this.scheduled,
        failed: failed ?? this.failed,
        detailsCount: detailsCount ?? this.detailsCount,
        deliveryAddress: deliveryAddress ?? this.deliveryAddress);
  }

  // OrderModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   userId = json['user_id'];
  //   orderAmount = json['order_amount'].toDouble();
  //   paymentStatus = json['payment_status'] ?? "pending";
  //   totalTaxAmount = 10.0;
  //   orderNote = json['order_note'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   orderStatus = json['order_status'];
  //   deliveryCharge = 10.0;
  //   scheduleAt = json['schedule_at'] ?? "";
  //   otp = json['otp'];
  //   pending = json['pending'] ?? "";
  //   accepted = json['accepted'] ?? "";
  //   confirmed = json['confirmed'] ?? "";
  //   processing = json['processing'] ?? "";
  //   handover = json['handover'] ?? "";
  //   pickedUp = json['picked_up'] ?? "";
  //   delivered = json['delivered'] ?? "";
  //   canceled = json['canceled'] ?? "";
  //   scheduled = json['scheduled'];
  //   failed = json['failed'] ?? "";
  //   detailsCount = json['details_count'];

  //   deliveryAddress = (json['delivery_address'] != null
  //       ? new AddressModel.fromJson(json['delivery_address'])
  //       : null)!;
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = id;
  //   data['user_id'] = userId;
  //   data['order_amount'] = orderAmount;

  //   data['payment_status'] = paymentStatus;
  //   data['total_tax_amount'] = totalTaxAmount;
  //   data['order_note'] = orderNote;
  //   data['created_at'] = createdAt;
  //   data['updated_at'] = updatedAt;
  //   data['delivery_charge'] = deliveryCharge;
  //   data['schedule_at'] = scheduleAt;
  //   data['otp'] = otp;
  //   data['pending'] = pending;
  //   data['accepted'] = accepted;
  //   data['confirmed'] = confirmed;
  //   data['processing'] = processing;
  //   data['handover'] = handover;
  //   data['picked_up'] = pickedUp;
  //   data['delivered'] = delivered;
  //   data['canceled'] = canceled;
  //   data['refund_requested'] = refundRequested;
  //   data['refunded'] = refunded;
  //   data['scheduled'] = scheduled;
  //   data['failed'] = failed;
  //   data['details_count'] = detailsCount;
  //   if (deliveryAddress != null) {
  //     data['delivery_address'] = deliveryAddress?.toJson();
  //   }
  //   return data;
  // }

}
