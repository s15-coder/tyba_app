import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tyba_app/bloc/user_cubit/user_cubit.dart';
import 'package:tyba_app/helpers/custom_alerts.dart';
import 'package:tyba_app/helpers/network_validator.dart';
import 'package:tyba_app/helpers/validations_fields.dart';
import 'package:tyba_app/pages/login_page.dart';
import 'package:tyba_app/pages/places_page.dart';
import 'package:tyba_app/widgets/auth_text_field.dart';
import 'package:tyba_app/widgets/container_fields_auth.dart';
import 'package:tyba_app/widgets/left_banner.dart';
import 'package:tyba_app/widgets/painters/login_painter.dart';
import 'package:tyba_app/widgets/right_banner.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);
  static const String routeName = "RegisterPage";

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ctrlEmail = TextEditingController();

  final ctrlPassword = TextEditingController();

  final ctrlName = TextEditingController();

  final FocusNode emailFocus = FocusNode();

  final FocusNode passwordFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              CustomPaint(
                painter: LoginPainter(context),
                child: const SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
              Positioned(
                right: 0,
                top: size.height * 0.15,
                child: RightBanner(
                  label: 'Login',
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    LoginPage.routeName,
                  ),
                ),
              ),
              FormRegister(
                ctrlEmail: ctrlEmail,
                ctrlPassword: ctrlPassword,
                ctrlName: ctrlName,
                emailFocus: emailFocus,
                passwordFocus: passwordFocus,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormRegister extends StatelessWidget {
  const FormRegister({
    Key? key,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.ctrlName,
    required this.emailFocus,
    required this.passwordFocus,
  }) : super(key: key);

  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final TextEditingController ctrlName;
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Registro',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 30),
          ContainerFieldsAuth(
            fields: [
              AuthTextField(
                hintText: "Name",
                textCapitalization: TextCapitalization.words,
                controller: ctrlName,
                prefixIcon: Icons.person_pin_circle_outlined,
                keyboardType: TextInputType.name,
                onSubmitted: (value) {
                  emailFocus.requestFocus();
                },
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                hintText: "Email",
                textCapitalization: TextCapitalization.sentences,
                controller: ctrlEmail,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocus,
                onSubmitted: (value) {
                  passwordFocus.requestFocus();
                },
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                obscureText: true,
                hintText: "Password",
                controller: ctrlPassword,
                prefixIcon: Icons.lock,
                focusNode: passwordFocus,
                onSubmitted: (value) => {},
              ),
            ],
            onSubmit: () => onSubmitRegister(context),
            submitIconData: Icons.check,
          )
        ],
      ),
    );
  }

  Future onSubmitRegister(BuildContext context) async {
    String name = ctrlName.value.text;
    String emailAddress = ctrlEmail.value.text;
    String password = ctrlPassword.value.text;
    //Validate fields
    String? errorText = ValidationsFields().validateFields([
      Field(
        typeField: TypeField.name,
        value: name,
        fieldName: 'Nombre',
      ),
      Field(
        typeField: TypeField.email,
        value: emailAddress,
        fieldName: emailAddress,
      ),
      Field(
        typeField: TypeField.password,
        value: password,
        fieldName: password,
      ),
    ]);
    if (errorText != null) {
      return showMessageAlert(
        context: context,
        title: 'Verificar',
        message: errorText,
      );
    }
    if (!await NewtworkValidator.checkNetworkAndAlert(context)) return;
    final userCubit = BlocProvider.of<UserCubit>(context);

    showLoadingAlert(context);
    final signedUp = await userCubit.signUp(
        emailAddress: emailAddress, password: password, name: name);
    Navigator.pop(context);
    if (signedUp) {
      Navigator.pushNamed(context, PlacesPage.routeName);
    }
  }
}
