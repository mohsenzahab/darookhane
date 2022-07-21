import 'package:darookhane/app/core/themes/colors.dart';
import 'package:darookhane/app/core/themes/decoration.dart';
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
    Widget widget = Center(
      child: FractionallySizedBox(
        widthFactor: .9,
        child: Column(
          children: [
            if (true)
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
                          CupertinoSearchTextField(
                              backgroundColor: kColorSearchBackground,
                              placeholderStyle: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: kColorSearchPlaceHolder),
                              placeholder:
                                  LocaleKeys.text_field_search_doctor_name.tr,
                              onChanged: (str) {
                                c.searchDoctor(str);
                              }),
                      ],
                    );
                  })
            else
              const HomeBarDesktop(),
            kSpaceHorizontal16,
            Expanded(
              child: GetBuilder<HomeController>(
                  id: '1',
                  builder: (c) {
                    if (true && c.showDoctors) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const ButtonDate(),
                          kSpaceHorizontal16,
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.only(top: 20),
                              decoration: kDecorationForm,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    LocaleKeys.text_title_doctors_list.tr,
                                    style: TextStyle(
                                        fontSize: 27,
                                        fontWeight: FontWeight.w600,
                                        color: Theme.of(Get.context!)
                                            .primaryColor),
                                    textAlign: TextAlign.center,
                                  ),
                                  kSpaceHorizontal16,
                                  Flexible(
                                    child: FutureBuilder<
                                            Map<Specialty, List<Doctor>>>(
                                        future: controller.specialties,
                                        builder: ((context, snapshot) {
                                          if (snapshot.hasData) {
                                            List<Doctor> doctors = c
                                                        .selectedSpecialty ==
                                                    null
                                                ? snapshot.data!.values
                                                    .fold<List<Doctor>>(
                                                        [],
                                                        (previousValue,
                                                                element) =>
                                                            previousValue
                                                              ..addAll(element))
                                                : snapshot.data![
                                                    c.selectedSpecialty]!;

                                            if (c.searchedDoctorName != null) {
                                              doctors = doctors
                                                  .where((d) => d.name.contains(
                                                      c.searchedDoctorName!))
                                                  .toList(growable: false);
                                            }

                                            return ListView(
                                              padding: const EdgeInsets.all(15),
                                              // primary: true,
                                              // shrinkWrap: true,
                                              children: doctors
                                                  .map((e) =>
                                                      CardDoctor(doctor: e))
                                                  .toList(growable: false),
                                            );
                                          } else {
                                            return const CircularProgressIndicator();
                                          }
                                        })),
                                  )
                                ],
                              ),
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
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 27,
                                      color:
                                          Theme.of(Get.context!).primaryColor)),
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
                                            fillColor: kColorFill,
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
                              if (true) ...[
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
                  }),
            )
          ],
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
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(kBorderRadiusVal),
                topLeft: Radius.circular(kBorderRadiusVal))),
        child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            children: [
              const MAvatar(),
              ListTileTheme(
                shape:
                    RoundedRectangleBorder(borderRadius: kBorderRadiusCircular),
                child: ListTile(
                  tileColor: kColorDoctorCard,
                  title: const Text(
                    'مشاهده رزروها',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: controller.toReservations,
                ),
              )
            ]),
      ),
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
              child: Text('نام کامل کاربر'),
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
            child: IconButton(
              icon: Image.asset('assets/icons/back.png'),
              onPressed: backPressed,
            ),
          ),
      ],
    );
  }
}
