import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';

class CallController extends GetxController {
  RxInt myremoteUid = 0.obs;
  RxBool localUserJoined = false.obs;
  RxBool muted = false.obs;
  RxBool videoPaused = false.obs;
  RxBool switchMainView = false.obs;
  RxBool mutedVideo = true.obs;
  RxBool reConnectingRemoteView = false.obs;
  RxBool isFront = false.obs;
  late RtcEngine engine;
  dynamic argumentData = Get.arguments;
  var token = "".obs;
  var channelId = "".obs;
  var otherUserName = "".obs;
  var otherUserImage = "".obs;

  @override
  void onInit() async {
    token(argumentData[0]["token"]);
    channelId(argumentData[0]["channelId"]);
    otherUserName(argumentData[0]["otherUserName"]);
    otherUserImage(argumentData[0]["otherUserImage"]);
    super.onInit();
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    Wakelock.enable();
    initilize();
  }

  @override
  void onClose() {
    Wakelock.disable();
    super.onClose();
    clear();
  }

  Future<void> _handleCameraAndMic(Permission permission) async {
    // ignore: unused_local_variable
    final status = await permission.request();
    // print(status);
  }

  clear() {
    engine.leaveChannel();
    isFront.value = false;
    reConnectingRemoteView.value = false;
    videoPaused.value = false;
    muted.value = false;
    mutedVideo.value = false;
    switchMainView.value = false;
    localUserJoined.value = false;
    update();
  }

  Future<void> initilize() async {
    Future.delayed(Duration.zero, () async {
      await _initAgoraRtcEngine();
      _addAgoraEventHandlers();
      await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      VideoEncoderConfiguration configuration =
          const VideoEncoderConfiguration();
      await engine.setVideoEncoderConfiguration(configuration);
      await engine.leaveChannel();
      await engine.joinChannel(
        // token: argumentData[0]["token"],
        // channelId: argumentData[0]["channelId"],
        token: token.value.toString(),
        channelId: channelId.value.toString(),
        uid: 0,
        options: const ChannelMediaOptions(),
      );
      update();
    });
  }

  Future<void> _initAgoraRtcEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(const RtcEngineContext(
      appId: "1084454e33904f689fb0584298ff0c82",
      channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
    ));
    // await engine.enableVideo();
    //await engine.startPreview();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
  }

  void _addAgoraEventHandlers() {
    engine.registerEventHandler(
      RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            localUserJoined.value = true;
            update();
          },
          onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
            localUserJoined.value = true;
            myremoteUid.value = remoteUid;
            update();
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            if (reason == UserOfflineReasonType.userOfflineDropped) {
              Wakelock.disable();
              myremoteUid.value = 0;
              // onCallEnd();
              update();
            } else {
              myremoteUid.value = 0;
              // onCallEnd();
              update();
            }
          },
          onRemoteVideoStats:
              (RtcConnection connection, RemoteVideoStats remoteVideoStats) {
            if (remoteVideoStats.receivedBitrate == 0) {
              videoPaused.value = true;
              update();
            } else {
              videoPaused.value = false;
              update();
            }
          },
          onTokenPrivilegeWillExpire:
              (RtcConnection connection, String token) {},
          onLeaveChannel: (RtcConnection connection, stats) {
            clear();
            // onCallEnd();
            update();
          }),
    );
  }

  Future onVideoOff() async {
    // mutedVideo.value = !mutedVideo.value;
    if (mutedVideo.value == false) {
      await engine.disableVideo();
    } else {
      await engine.enableVideo();
    }
    mutedVideo(!mutedVideo.value);
    //  await engine.muteLocalVideoStream(mutedVideo.value);

    update();
  }

  void onCallEnd() {
    // clear();
    update();
    // Get.offAll(() => const ChatView());
    Get.back();
  }

  void onToggleMute() {
    muted.value = !muted.value;
    engine.muteLocalAudioStream(muted.value);
    update();
  }

  void onToggleMuteVideo() {
    mutedVideo(!mutedVideo.value);
    // engine.muteLocalVideoStream(mutedVideo.value);
    // engine.disableVideo();
    update();
  }

  void onSwitchCamera() {
    // ignore: body_might_complete_normally_catch_error
    engine.switchCamera().then((value) => {}).catchError((err) {});
  }
}
