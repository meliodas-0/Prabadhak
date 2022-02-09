import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<bool> backPressed(
    BuildContext context, GlobalKey<ScaffoldState>? key) async {
  if (key != null &&
      key.currentState!.hasDrawer &&
      key.currentState!.isDrawerOpen) {
    Navigator.pop(context);
    return Future.value(false);
  }

  return await exitAlertDialogBox(context) ?? Future.value(false);
}

Future exitAlertDialogBox(BuildContext context) {
  return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.blueGrey.withOpacity(0.5),
      builder: (BuildContext context) {
        return Container(
          color: Colors.transparent,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Wrap(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Card(
                    elevation: 3.0,
                    color: Colors.blue.shade50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20.0,
                        bottom: 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Would you like to exit?',
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                            ),
                            // maxLines: 3,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.red),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(
                                        left: 35.0,
                                        right: 35.0,
                                        top: 10.0,
                                        bottom: 8.0),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                // textColor: Colors.white,
                                label: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () => Navigator.pop(context),
                                // Navigator.of(context).pop(false),
                              ),
                              const SizedBox(
                                width: 20.0,
                              ),
                              ElevatedButton.icon(
                                style: ButtonStyle(
                                  overlayColor: MaterialStateColor.resolveWith(
                                      (states) => Colors.blue),
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.only(
                                        left: 35.0,
                                        right: 35.0,
                                        top: 10.0,
                                        bottom: 8.0),
                                  ),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.done,
                                  color: Colors.white,
                                ),
                                // textColor: Colors.white,
                                label: const Text(
                                  'OK',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  SystemNavigator.pop();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
