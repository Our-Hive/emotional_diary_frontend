import 'package:emotional_app/features/account/user/domain/entities/user.dart';
import 'package:emotional_app/features/account/user/ui/provider/user_provider.dart';
import 'package:emotional_app/shared/domain/utils/date_time_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileView extends ConsumerStatefulWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userProvider.notifier).getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final User user = ref.watch(userProvider).currentUser;
    final appColors = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 5),
                  ...[
                    ImageFiltered(
                      imageFilter: ColorFilter.mode(
                        user.photoColor,
                        BlendMode.srcATop,
                      ),
                      child: const Image(
                        image: AssetImage('assets/app_image.png'),
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Hola\r${user.firstName}\r${user.lastName}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      user.email,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white60,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _ActiveTextFormField(
                      appColors: appColors,
                      primaryText: 'Username',
                      secondaryText: user.userName,
                    ),
                    const SizedBox(height: 15),
                    _ActiveTextFormField(
                      appColors: appColors,
                      primaryText: 'Numero',
                      secondaryText: '+57 3214562145',
                    ),
                    const SizedBox(height: 15),
                    _ActiveTextFormField(
                      appColors: appColors,
                      primaryText: 'Fecha de Nacimiento',
                      secondaryText: DateTimeFormatter.getFormattedDate(
                        user.birthDate,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: appColors.onSecondary),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: FilledButton.icon(
                        onPressed: () => print('Pressed'),
                        style: FilledButton.styleFrom(
                          backgroundColor: appColors.secondary,
                          foregroundColor: appColors.onSecondary,
                        ),
                        icon: const Icon(Icons.edit),
                        label: const Text('Editar perfil'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    FilledButton.icon(
                      onPressed: () => print('Pressed'),
                      style: FilledButton.styleFrom(
                        backgroundColor: appColors.error,
                        foregroundColor: appColors.onError,
                      ),
                      icon: const Icon(Icons.delete),
                      label: const Text('Deshabilitar cuenta'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ActiveTextFormField extends StatefulWidget {
  final ColorScheme appColors;
  final String primaryText;
  final String secondaryText;

  const _ActiveTextFormField({
    required this.appColors,
    required this.primaryText,
    required this.secondaryText,
  });

  @override
  State<_ActiveTextFormField> createState() => _ActiveTextFormFieldState();
}

class _ActiveTextFormFieldState extends State<_ActiveTextFormField> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      onTap: () => setState(() => isSelected ? false : true),
      decoration: InputDecoration(
        labelText: isSelected ? widget.primaryText : widget.secondaryText,
        hintText: !isSelected ? widget.primaryText : widget.secondaryText,
        labelStyle: TextStyle(color: widget.appColors.primary),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: widget.appColors.primary,
          ),
        ),
      ),
    );
  }
}
