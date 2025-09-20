import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pcom_app/app/core/core.dart';
import 'package:pcom_app/common/widgets/primary_button.dart';
import '../../../../../common/widgets/my_text.dart';
import '../controllers/profile_controller.dart';

class ProfileEdit extends GetView<ProfileController> {
  const ProfileEdit({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: MyText(text: 'My Profile', fontSize: 20),
          centerTitle: true,
        ),
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/background.svg",
              fit: BoxFit.fill,
              alignment: Alignment.bottomCenter,
              allowDrawingOutsideViewBox: true,
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: 24.all,
              child: Column(
                children: [

                  Container(
                    width: 1.sw,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children:
                      [
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 110,
                              height: 110,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: R.theme.primary, width: 1),
                              ),
                              padding: const EdgeInsets.all(3),
                              child: const CircleAvatar(
                                backgroundImage: NetworkImage(
                                  'https://images.unsplash.com/photo-1527980965255-d3b416303d12?q=80&w=600&auto=format&fit=crop',
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8,
                              bottom: 8,
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: R.theme.primary,
                                  shape: BoxShape.circle,
                                  boxShadow: const [
                                    BoxShadow(color: Colors.black54, blurRadius: 6)
                                  ],
                                ),
                                child: SvgPicture.asset('assets/icons/ic_image_add.svg'),
                              ),
                            ),
                          ],
                        ),

                        12.sbh,

                        MyText(
                              text: 'Samilon',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: R.theme.primary,
                            )
                      ],
                    ),
                  ),

                  Column(
                    children: [

                      TextFormField(
                        controller: controller.name,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                        },
                      ),

                      24.sbh,

                      TextFormField(
                        controller: controller.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                        ),
                      ),

                      24.sbh,

                      TextFormField(
                        controller: controller.phone,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                          prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                          prefix: InkWell(
                            onTap: () async {
                              final result = await showModalBottomSheet<String>(
                                context: context,
                                backgroundColor:
                                const Color(0xFF0F172A), // dark sheet
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20)),
                                ),
                                builder: (ctx) => _CountrySheet(
                                  items: controller.countries,
                                  selected: controller.selectedCountry,
                                ),
                              );
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 12),
                                Text(
                                  controller.selectedCountry,
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                                const SizedBox(width: 6),
                                const Icon(Icons.arrow_drop_down,
                                    size: 20, color: Colors.white70),
                                const SizedBox(width: 12),
                              ],
                            ),
                          ),
                        ),

                      ),

                      24.sbh,

                      TextFormField(
                        controller: controller.birthdayController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Birthday',
                          labelStyle: TextStyle(color: R.theme.primary),
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => controller.pickDate(context),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your birthday';
                          }
                          return null;
                        },
                      ),

                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: 12.all,
        child: SizedBox(
          height: 56,
          child: PrimaryButton(color: R.theme.primary, text: 'Save', onPressed: () => {}),
        ),
      ),
    );
  }
}

class _CountrySheet extends StatelessWidget {
  const _CountrySheet({
    required this.items,
    required this.selected,
  });

  final List<String> items;
  final String selected;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: items.length,
      separatorBuilder: (_, __) => const Divider(height: 1, color: Colors.white12),
      itemBuilder: (context, i) {
        final item = items[i];
        final isSel = item == selected;
        return ListTile(
          title: Text(item),
          trailing: isSel
              ? const Icon(Icons.check, color: Colors.white70)
              : null,
          onTap: () => Navigator.of(context).pop(item),
        );
      },
    );
  }
}