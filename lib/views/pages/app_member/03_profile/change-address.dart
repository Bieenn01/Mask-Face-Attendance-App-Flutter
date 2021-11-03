import 'package:face_attendance/constants/app_sizes.dart';
import 'package:face_attendance/services/app_toast.dart';
import 'package:face_attendance/services/form_verify.dart';
import 'package:face_attendance/views/themes/text.dart';
import 'package:face_attendance/views/widgets/app_button.dart';
import 'package:firebase_core/firebase_core.dart';

import '../../../../constants/app_defaults.dart';
import '../../../../controllers/user/app_member_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeAddressSheet extends StatefulWidget {
  const ChangeAddressSheet({Key? key}) : super(key: key);

  @override
  _ChangeAddressSheetState createState() => _ChangeAddressSheetState();
}

class _ChangeAddressSheetState extends State<ChangeAddressSheet> {
  /// Dependency
  AppMemberUserController _controller = Get.find();

  // Form Key
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  /// Text
  late TextEditingController _address;

  /// Progress
  RxBool _isUpdating = false.obs;

  /// on update
  Future<void> _onAddressUpdate() async {
    bool _isFormOkay = _formKey.currentState!.validate();
    if (_isFormOkay) {
      try {
        _isUpdating.trigger(true);
        await _controller.changeUserAddress(address: _address.text);
        _isUpdating.trigger(false);
        Get.back();
      } on FirebaseException catch (e) {
        AppToast.showDefaultToast(e.message ?? "Something error happened");
        _isUpdating.trigger(false);
        Get.back();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _address = TextEditingController();
    _address.text = _controller.currentUser.address == null
        ? ''
        : _controller.currentUser.address!;
  }

  @override
  void dispose() {
    _address.dispose();
    _isUpdating.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.DEFAULT_PADDING),
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: AppDefaults.defaultBottomSheetRadius,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Text(
            'Update Address',
            style: AppText.h6,
          ),

          /// DIVIDER
          AppSizes.hGap10,
          Divider(),
          AppSizes.hGap20,

          /// FORM
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _address,
              decoration: InputDecoration(
                labelText: 'Address',
                hintText: 'Ocean City, B-Block',
              ),
              validator: (text) {
                return AppFormVerify.address(address: text);
              },
              onFieldSubmitted: (v) {
                _onAddressUpdate();
              },
            ),
          ),
          AppSizes.hGap20,

          /// BUTTON
          Obx(
            () => AppButton(
              label: 'Update',
              isLoading: _isUpdating.value,
              onTap: _onAddressUpdate,
            ),
          ),
        ],
      ),
    );
  }
}