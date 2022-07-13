import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/widgets/avatar.dart';
import 'package:darookhane/app/widgets/button_drop_down.dart';
import 'package:darookhane/app/widgets/card_doctor.dart';
import 'package:darookhane/app/widgets/form_container.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetResponsiveView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  @override
  Widget builder() {
    Widget widget = SingleChildScrollView(
      child: Center(
        child: FractionallySizedBox(
          widthFactor: .9,
          child: Column(
            children: [
              if (screen.isPhone)
                GetBuilder<HomeController>(
                    id: '1',
                    builder: (c) {
                      return HomeBarPhone(
                        showAvatar: !c.showDoctors,
                        backPressed: () => c.showDoctors = false,
                      );
                    })
              else
                const HomeBarDesktop(),
              kSpaceVertical32,
              ConstrainedBox(
                constraints: const BoxConstraints(
                    maxWidth: kFormMaxWidth, minWidth: kFormMinWidth),
                child: CupertinoSearchTextField(
                    placeholder: LocaleKeys.text_field_search_doctor_name.tr),
              ),
              kSpaceHorizontal16,
              GetBuilder<HomeController>(
                  id: '1',
                  builder: (c) {
                    if (screen.isPhone && c.showDoctors) {
                      return Column(
                        children: [
                          if (screen.isPhone) ButtonDate(),
                          kSpaceHorizontal16,
                          FormContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  LocaleKeys.text_title_doctors_list.tr,
                                  textAlign: TextAlign.center,
                                ),
                                kSpaceHorizontal16,
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return FormContainer(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(LocaleKeys.text_title_scheduling_system.tr,
                                  textAlign: TextAlign.center),
                              kSpaceVertical32,
                              MDropDownButton(
                                hint:
                                    LocaleKeys.button_drop_down_select_city.tr,
                                items: ['1', '2'],
                                onChanged: (s) {},
                              ),
                              kSpaceVertical16,
                              MDropDownButton(
                                hint: LocaleKeys
                                    .button_drop_down_select_specialty.tr,
                                items: ['1', '2'],
                                onChanged: (s) {},
                              ),
                              if (screen.isPhone) ...[
                                kSpaceHorizontal32,
                                ElevatedButton(
                                    onPressed: () {
                                      c.showDoctors = true;
                                    },
                                    child: Text(LocaleKeys.button_search.tr))
                              ] else
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: []
                                      .map((e) => CardDoctor(doctor: e))
                                      .toList(),
                                )
                            ]),
                      );
                    }
                  })
            ],
          ),
        ),
      ),
    );
    // if (screen.width < kFormMinWidth) {
    //   widget = SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: widget,
    //   );
    // }
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.only(top: 50),
        child: widget,
      ),
    );
  }
}

class HomeBarDesktop extends StatelessWidget {
  const HomeBarDesktop({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            MAvatar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('نام کامل کاربر'),
            )
          ],
        ),
        ButtonDate(),
      ],
    );
  }
}

class ButtonDate extends StatelessWidget {
  const ButtonDate({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.calendar_month,
              color: Colors.white,
            ),
            Text(
              'date',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ));
  }
}

class HomeBarPhone extends StatelessWidget {
  HomeBarPhone({
    Key? key,
    this.showAvatar = true,
    this.backPressed,
  }) : super(key: key);

  final bool showAvatar;

  final void Function()? backPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {},
            iconSize: kSizeIcon,
            visualDensity: VisualDensity.compact,
            icon: Icon(
              Icons.draw,
            )),
        if (showAvatar)
          MAvatar()
        else
          Directionality(
            textDirection: TextDirection.ltr,
            child: BackButton(
              onPressed: backPressed,
            ),
          ),
      ],
    );
  }
}
