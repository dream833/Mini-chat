import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'package:kulturella/app/data/config/app_color.dart';
import '../controllers/call_controller.dart';

class CallView extends GetView<CallController> {
  const CallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final callCon = Get.put(CallController());
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() => Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Center(
                      child: callCon.localUserJoined == true
                          ? callCon.videoPaused == true
                              ? Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Center(
                                      child: Text(
                                    "Remote Video Paused",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white70),
                                  )))
                              : AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: callCon.engine,
                                    canvas: VideoCanvas(
                                        uid: callCon.myremoteUid.value),
                                    connection: RtcConnection(
                                        channelId: controller.channelId.value
                                            .toString()),
                                  ),
                                )
                          : const Center(
                              child: Text(
                                'No Remote',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 100,
                        height: 150,
                        child: Center(
                            child: callCon.localUserJoined.value
                                ? AgoraVideoView(
                                    controller: VideoViewController(
                                      rtcEngine: callCon.engine,
                                      canvas: const VideoCanvas(uid: 0),
                                    ),
                                  )
                                : const Text("")),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(
                                controller.otherUserImage.toString()),
                            //  FileImage(getBox.read(USER_IMAGE)),
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          "Calling ${controller.otherUserName.substring(0, 1).toUpperCase() + controller.otherUserName.substring(
                                1,
                              ).toLowerCase()} ....",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      // ignore: avoid_unnecessary_containers
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  callCon.onToggleMute();
                                },
                                child: Icon(
                                  callCon.muted.value
                                      ? Icons.mic_off
                                      : Icons.mic,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {
                                  callCon.onCallEnd();
                                  // Get.to(const HomeView());
                                },
                                child: const Icon(
                                  Icons.call,
                                  size: 35,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            // Expanded(
                            //   flex: 1,
                            //   child: InkWell(
                            //     onTap: () {
                            //     callCon.onToggleMuteVideo();
                            //     },
                            //     child: const CircleAvatar(
                            //       backgroundColor: Colors.white,
                            //       child: Padding(
                            //         padding: EdgeInsets.all(5),
                            //         child: Center(
                            //           child: Icon(
                            //             Icons.photo_camera_front,
                            //             size: 25,
                            //             color: Colors.black,
                            //           ),
                            //         ),
                            //       ),
                            //     ),
                            //   ),
                            // ),
                            // Expanded(
                            //   flex: 1,
                            //   child: InkWell(
                            //     onTap: () {
                            //       callCon.onSwitchCamera();
                            //     },
                            //     child: const Icon(
                            //       Icons.switch_camera,
                            //       size: 35,
                            //       color: Colors.white,
                            //     ),
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
