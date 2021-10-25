// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:thaartransport/auth/login_view_modal.dart';
import 'package:thaartransport/modal/usermodal.dart';
import 'package:thaartransport/screens/profile/editprofileviewmodal.dart';
import 'package:thaartransport/utils/constants.dart';
import 'package:thaartransport/utils/firebase.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:dropdown_search/dropdown_search.dart';

class EditProfile extends StatefulWidget {
  final UserModel user;

  const EditProfile({required this.user});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final GlobalKey<FormState> _role = GlobalKey<FormState>();

  UserModel? user;

  String currentUid() {
    return firebaseAuth.currentUser!.uid;
  }

  @override
  Widget build(BuildContext context) {
    EditProfileViewModel viewModel = Provider.of<EditProfileViewModel>(context);
    return LoadingOverlay(
      isLoading: false,
      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Edit Profile"),
          actions: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(right: 25.0),
                child: GestureDetector(
                  onTap: () {
                    viewModel.editProfile(context);
                  },
                  child: Text(
                    'SAVE',
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 15.0,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => viewModel.pickImage(context: context),
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.transparent,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        offset: new Offset(0.0, 0.0),
                        blurRadius: 2.0,
                        spreadRadius: 0.0,
                      ),
                    ],
                  ),
                  child: viewModel.imgLink != null
                      ? Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: CircleAvatar(
                            radius: 65.0,
                            backgroundImage: NetworkImage(viewModel.imgLink!),
                          ),
                        )
                      : viewModel.image == null
                          ? Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage:
                                    NetworkImage(widget.user.photourl!),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: CircleAvatar(
                                radius: 65.0,
                                backgroundImage: FileImage(viewModel.image!),
                              ),
                            ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            buildForm(viewModel, context)
          ],
        ),
      ),
    );
  }

  buildForm(EditProfileViewModel viewModel, BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Form(
        key: viewModel.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              enabled: !viewModel.loading,
              initialValue: widget.user.username,
              decoration: InputDecoration(
                  hintText: "Username",
                  labelText: 'UserName',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.textfieldborder, width: 2.5)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.5, color: Constants.textfieldborder))),
              textInputAction: TextInputAction.next,
              onChanged: (val) {
                viewModel.setUsername(val);
              },
              onSaved: (val) {
                viewModel.setUsername(val!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter the name';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              initialValue: widget.user.companyname,
              enabled: !viewModel.loading,
              decoration: InputDecoration(
                  hintText: "Company Name",
                  labelText: 'Company Name',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.textfieldborder, width: 2.5)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.5, color: Constants.textfieldborder))),
              textInputAction: TextInputAction.next,
              onChanged: (String val) {
                viewModel.setcompanyname(val);
              },
              onSaved: (val) {
                viewModel.setcompanyname(val!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your Company Name';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            TextFormField(
              maxLines: null,
              initialValue: widget.user.location,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                  hintText: 'location',
                  labelText: 'Location',
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Constants.textfieldborder, width: 2.5)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 2.5, color: Constants.textfieldborder))),
              onChanged: (String val) {
                viewModel.setlocation(val);
              },
              onSaved: (val) {
                viewModel.setlocation(val!);
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter your location';
                }
                return null;
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            DropdownSearch<String>(
                mode: Mode.BOTTOM_SHEET,
                showSelectedItems: true,
                items: const [
                  "Shipper",
                  "Truck Owner",
                  'Shipper & Truck Owner'
                ],
                hint: "select the role",
                label: 'Role',
                autoValidateMode: AutovalidateMode.onUserInteraction,
                popupItemDisabled: (String s) => s.startsWith('I'),
                onChanged: (val) {
                  viewModel.setrole(val);
                },
                onSaved: (val) {
                  viewModel.setrole(val);
                },
                validator: (value) {
                  if (value == null)
                    return "Required field";
                  else
                    return null;
                },
                selectedItem: widget.user.role),
          ],
        ),
      ),
    );
  }
}
