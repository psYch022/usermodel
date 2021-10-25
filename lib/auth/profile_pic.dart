import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaartransport/auth/post_view_modal.dart';
import 'package:thaartransport/components/custom_image.dart';
import 'package:thaartransport/widget/indicatiors.dart';
import 'package:loading_overlay/loading_overlay.dart';

class ProfilePicture extends StatefulWidget {
  @override
  _ProfilePictureState createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  @override
  Widget build(BuildContext context) {
    PostsViewModel viewModel = Provider.of<PostsViewModel>(context);
    return LoadingOverlay(
      isLoading: false,
      progressIndicator: circularProgress(context),
      // inAsyncCall: viewModel.loading,

      child: Scaffold(
        key: viewModel.scaffoldKey,
        appBar: AppBar(
          title: const Text('Add a profile picture'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          children: [
            InkWell(
              onTap: () => showImageChoices(context, viewModel),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width - 30,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.all(
                    Radius.circular(3.0),
                  ),
                  border: Border.all(
                    color: Theme.of(context).accentColor,
                  ),
                ),
                child: viewModel.imgLink != null
                    ? CustomImage(
                        imageUrl: viewModel.imgLink!,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width - 30,
                        fit: BoxFit.cover,
                      )
                    : viewModel.mediaUrl == null
                        ? Center(
                            child: Text(
                              'upload your profile picture',
                              style: TextStyle(
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          )
                        : Image.file(
                            viewModel.mediaUrl!,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.width - 30,
                            fit: BoxFit.cover,
                          ),
              ),
            ),
            SizedBox(height: 10.0),
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).accentColor),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
                child: Center(
                  child: Text('done'.toUpperCase()),
                ),
                onPressed: () => viewModel.uploadProfilePicture(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showImageChoices(BuildContext context, PostsViewModel viewModel) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: .6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'Select'.toUpperCase(),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(camera: true, context: context);
                },
              ),
              ListTile(
                leading: Icon(Icons.file_copy_rounded),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  viewModel.pickImage(context: context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
