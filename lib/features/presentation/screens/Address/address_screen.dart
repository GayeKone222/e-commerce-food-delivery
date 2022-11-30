import 'dart:io';

import 'package:e_commerce/core/dependency_injection.dart/injections.dart';
import 'package:e_commerce/core/utils/colors.dart';
import 'package:e_commerce/core/utils/enums.dart';
import 'package:e_commerce/features/domain/entities/user_entity.dart';
import 'package:e_commerce/features/presentation/bloc/address_bloc/address_bloc.dart';
import 'package:e_commerce/features/presentation/cubit/address_cubit/address_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/auth_status_cubit/auth_status_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/location_type_cubit/location_type_cubit.dart';
import 'package:e_commerce/features/presentation/cubit/position_cubit/position_cubit.dart';
import 'package:e_commerce/features/presentation/widgets/Auth/app_text_field.dart';
import 'package:e_commerce/features/presentation/widgets/common/big_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key, required this.user}) : super(key: key);

  final UserEntity user;

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late TextEditingController addressController;
  late TextEditingController contactPersonNameController;
  late TextEditingController contactPersonNumberController;

  late bool isLoggedIn;
  CameraPosition cameraPosition =
      const CameraPosition(target: LatLng(45.51563, -122.677433), zoom: 17);

  late LatLng initialPosition;
  //late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController();
    contactPersonNameController = TextEditingController();
    contactPersonNumberController = TextEditingController();
    isLoggedIn = BlocProvider.of<AuthStatusCubit>(context).state;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddressBloc>(
            lazy: false,
            create: (_) => sl<AddressBloc>()..add(GetUserAddress())),
        BlocProvider<AddressCubit>(create: (_) => sl<AddressCubit>()),
        BlocProvider<LocationTypeCubit>(create: (_) => sl<LocationTypeCubit>()),
        BlocProvider<PositionCubit>(create: (_) => sl<PositionCubit>()),
      ],

      //slazy: true,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Address page"),
            backgroundColor: AppColors.mainColor,
          ),
          body: BlocListener<AddressBloc, AddressState>(
              listener: (context, state) {
                if (state.status == AppStateStatus.success) {
                  BlocProvider.of<PositionCubit>(context).setNewPosition(
                      latLng: LatLng(
                          double.parse(state.addressEntity!.latitude),
                          double.parse(state.addressEntity!.longitude)));
                }
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(5.w, 5.h, 5.w, 0),
                      height: 140.h,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            width: 2, color: AppColors.mainColor),
                      ),
                      child: Stack(
                        children: [
                          Builder(builder: (context) {
                            return BlocBuilder<PositionCubit, Position?>(
                              builder: (context, state) {
                                return GoogleMap(
                                  initialCameraPosition: CameraPosition(
                                      //45.51563, -122.677433
                                      target: LatLng(
                                          state?.latitude ?? 45.51563,
                                          state?.longitude ?? -122.677433),
                                      zoom: 17),
                                  zoomControlsEnabled: false,
                                  compassEnabled: false,
                                  indoorViewEnabled: true,
                                  mapToolbarEnabled: false,
                                  myLocationEnabled: true,
                                  onCameraIdle: () {
                                    //  print("onCameraIdle : $cameraPosition");
                                    BlocProvider.of<AddressCubit>(context)
                                        .getAddressFromGeocode(
                                            latLng: LatLng(
                                                // cameraPosition.target.latitude,
                                                // cameraPosition.target.longitude
                                                state!.latitude,
                                                state.longitude));
                                  },
                                  onCameraMove: (position) {
                                    BlocProvider.of<PositionCubit>(context)
                                        .setNewPosition(
                                            latLng: LatLng(
                                                position.target.latitude,
                                                position.target.longitude));
                                  },
                                  // onMapCreated: (GoogleMapController controller) {},
                                );
                              },
                            );
                          }),
                        ],
                      ),
                    ),
                    BlocBuilder<LocationTypeCubit, int>(
                      builder: (context, state) {
                        return Container(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          height: 50.h,
                          child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      BlocProvider.of<LocationTypeCubit>(
                                              context)
                                          .changeLocationType(index: index);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.w, vertical: 10.h),
                                      margin: EdgeInsets.only(right: 10.w),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          color: Theme.of(context).cardColor,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey[200]!,
                                                spreadRadius: 1,
                                                blurRadius: 5)
                                          ]),
                                      child: Icon(
                                          index == 0
                                              ? Icons.home_filled
                                              : index == 1
                                                  ? Icons.work
                                                  : Icons.location_on,
                                          color: index == state
                                              ? AppColors.mainColor
                                              : Theme.of(context)
                                                  .disabledColor),
                                    ));
                              }),
                        );
                      },
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w),
                      child: const Bigtext(text: "Delivery Address"),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocBuilder<AddressCubit, Placemark>(
                      builder: (context, state) {
                        addressController.text = state.name ?? "No address";
                        return ApptextField(
                            controller: addressController,
                            hintText: "Your address",
                            icon: Icons.map);
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.w, top: 10.h),
                      child: const Bigtext(text: "Name"),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        contactPersonNameController.text =
                            state.addressEntity?.contactPersonName ??
                                widget.user.name!;
                        return ApptextField(
                            controller: contactPersonNameController,
                            hintText: "Your name",
                            icon: Icons.map);
                      },
                    ),
                    Padding(
                         padding: EdgeInsets.only(left: 20.w, top: 10.h),
                      child: const Bigtext(text: "Phone"),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    BlocBuilder<AddressBloc, AddressState>(
                      builder: (context, state) {
                        contactPersonNumberController.text =
                            state.addressEntity?.contactPersonNumber ??
                                widget.user.phone!;
                        return ApptextField(
                            controller: contactPersonNumberController,
                            hintText: "Your phone",
                            icon: Icons.map);
                      },
                    )
                  ],
                ),
              ))),
    );
  }
}
