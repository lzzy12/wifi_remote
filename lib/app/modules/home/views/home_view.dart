import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:wifi_remote/app/modules/home/controllers/home_controller.dart';
import 'package:wifi_remote/app/services/app_theme_service.dart';
import 'package:wifi_remote/utils/remote_commands.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final HomeController controller = Get.find();
    AppThemeService theme = Get.find();
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: theme.background,
          title: RichText(
            text: TextSpan(
              text: 'ESP32',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: theme.text,
                fontSize: 20,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Remote Control',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    color: theme.text,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.dark_mode,
                size: 28,
              ),
              onPressed: () => theme.toggleTheme(),
              color: theme.select,
            ),
          ],
        ),
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            color: theme.background,
            child: FittedBox(
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      width: size.width,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Form(
                          key: controller.formKey,
                          child: TextFormField(
                            style: TextStyle(color: theme.text),
                            decoration: InputDecoration(
                                label: const Text("IP Address"),
                                hintText: "192.168.13.250",
                                hintStyle:
                                    TextStyle(color: theme.text, fontSize: 10),
                                labelStyle:
                                    TextStyle(color: theme.text, fontSize: 20)),
                            validator: (value) =>
                                controller.ipAddressValidator(value),
                            controller: controller.ipAddressController,
                            onEditingComplete: controller.onFormSave,
                            keyboardType: TextInputType.number,
                            onChanged: (value) => controller.onFormSave,
                            onFieldSubmitted: (value) => controller.onFormSave,
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                        onPressed: controller.onFormSave,
                        child: const Text("Set")),
                    SizedBox(
                      height: size.height / 10,
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.11,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(
                            width: size.height * 0.11,
                            height: size.height * 0.08,
                            child: Icon(
                              Icons.volume_down,
                              color: theme.icon,
                              size: 28,
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              controller.buttonPressed(RemoteCommands.power);
                              debugPrint("Power Pressed");
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              width: size.height * 0.11,
                              height: size.height * 0.11,
                              decoration: BoxDecoration(
                                color: theme.buttonBackground,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.power_settings_new,
                                color: Color(0xFFEF5252),
                                size: 38,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.height * 0.11,
                            height: size.height * 0.08,
                            child: Icon(
                              Icons.filter_list,
                              color: theme.icon,
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: size.width,
                      height: size.height * 0.25,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            width: size.width * 0.20,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              color: theme.buttonBackground,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () {
                                    controller
                                        .buttonPressed(RemoteCommands.volumeUp);
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: theme.iconButton,
                                    size: 38,
                                  ),
                                ),
                                Text(
                                  "Vol",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.text,
                                    fontSize: 24,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller
                                      .buttonPressed(RemoteCommands.volumeUp),
                                  child: Icon(
                                    Icons.remove,
                                    color: theme.iconButton,
                                    size: 38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(2),
                            width: size.width * 0.1,
                            height: size.width * 0.1,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Colors.blue,
                                  Colors.pink,
                                ],
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(18),
                              width: size.width * 0.4,
                              height: size.width * 0.4,
                              decoration: BoxDecoration(
                                color: theme.background,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          Container(
                            width: size.width * 0.20,
                            height: size.height * 0.25,
                            decoration: BoxDecoration(
                              color: theme.buttonBackground,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(40.0),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => controller
                                      .buttonPressed(RemoteCommands.channelUp),
                                  child: Icon(
                                    Icons.keyboard_arrow_up,
                                    color: theme.iconButton,
                                    size: 38,
                                  ),
                                ),
                                Text(
                                  "Ch",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: theme.text,
                                    fontSize: 24,
                                  ),
                                ),
                                InkWell(
                                  onTap: () => controller.buttonPressed(
                                      RemoteCommands.channelDown),
                                  child: Icon(
                                    Icons.keyboard_arrow_down,
                                    color: theme.iconButton,
                                    size: 38,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
