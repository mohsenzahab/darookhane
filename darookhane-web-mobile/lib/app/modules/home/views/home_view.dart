import 'package:darookhane/app/core/values/screen_values.dart';
import 'package:darookhane/app/data/enums/gender.dart';
import 'package:darookhane/app/data/models/doctor.dart';
import 'package:darookhane/app/data/models/specialty.dart';
import 'package:darookhane/app/widgets/avatar.dart';
import 'package:darookhane/app/widgets/button_drop_down.dart';
import 'package:darookhane/app/widgets/card_doctor.dart';
import 'package:darookhane/app/widgets/form_container.dart';
import 'package:darookhane/generated/locales.g.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:jalali_date_picker/jalali_date_picker.dart';

import '../controllers/home_controller.dart';
import 'widgets/button_date.dart';

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
                      return Column(
                        children: [
                          HomeBarPhone(
                            showAvatar: !c.showDoctors,
                            backPressed: () => c.showDoctors = false,
                          ),
                          kSpaceVertical32,
                          if (c.showDoctors)
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: kFormMaxWidth,
                                  minWidth: kFormMinWidth),
                              child: CupertinoSearchTextField(
                                  placeholder: LocaleKeys
                                      .text_field_search_doctor_name.tr),
                            ),
                        ],
                      );
                    })
              else
                const HomeBarDesktop(),
              kSpaceHorizontal16,
              GetBuilder<HomeController>(
                  id: '1',
                  builder: (c) {
                    if (screen.isPhone && c.showDoctors) {
                      return Column(
                        children: [
                          const ButtonDate(),
                          kSpaceHorizontal16,
                          FormContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  LocaleKeys.text_title_doctors_list.tr,
                                  textAlign: TextAlign.center,
                                ),
                                kSpaceHorizontal16,
                                FutureBuilder<Map<Specialty, List<Doctor>>>(
                                    future: controller.specialties,
                                    builder: ((context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView(
                                          shrinkWrap: true,
                                          children: snapshot
                                              .data![c.selectedSpecialty]!
                                              .map((e) => CardDoctor(doctor: e))
                                              .toList(growable: false),
                                        );
                                      } else {
                                        return const CircularProgressIndicator();
                                      }
                                    }))
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
                              // MDropDownButton(
                              //   hint:
                              //       LocaleKeys.button_drop_down_select_city.tr,
                              //   items: ['1', '2'],
                              //   onChanged: (s) {},
                              // ),
                              kSpaceVertical16,
                              GetBuilder<HomeController>(
                                id: 'data',
                                builder: (_) {
                                  return FutureBuilder<
                                          Map<Specialty, List<Doctor>>>(
                                      future: c.specialties,
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          return MDropDownButton(
                                            value: c.selectedSpecialty,
                                            hint: LocaleKeys
                                                .button_drop_down_select_specialty
                                                .tr,
                                            items: snapshot.data!.keys
                                                .toList(growable: false),
                                            onChanged: c.specialtyChanged,
                                          );
                                        } else {
                                          return const LinearProgressIndicator();
                                        }
                                      });
                                },
                              ),
                              if (screen.isPhone) ...[
                                kSpaceHorizontal32,
                                ElevatedButton(
                                    onPressed: c.searchDoctors,
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
      drawer: Drawer(
          child: ListView(
              // padding: const EdgeInsets.symmetric(vertical: 50),
              children: [
                MAvatar(),
                ListTile(
                  title: Text('مشاهده رزروها'),
                  onTap: controller.toReservations,
                )
              ]),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 50),
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
            const MAvatar(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: const Text('نام کامل کاربر'),
            )
          ],
        ),
        const ButtonDate(),
      ],
    );
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
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            iconSize: kSizeIcon,
            visualDensity: VisualDensity.compact,
            icon: Image.asset('assets/icons/menu.png')),
        if (showAvatar)
          const MAvatar()
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
