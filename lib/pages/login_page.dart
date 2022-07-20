import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyba_app/bloc/user_cubit/user_cubit.dart';
import 'package:tyba_app/helpers/custom_alerts.dart';
import 'package:tyba_app/helpers/network_validator.dart';
import 'package:tyba_app/helpers/validations_fields.dart';
import 'package:tyba_app/pages/places_page.dart';
import 'package:tyba_app/pages/register_page.dart';
import 'package:tyba_app/widgets/auth_text_field.dart';
import 'package:tyba_app/widgets/container_fields_auth.dart';
import 'package:tyba_app/widgets/left_banner.dart';
import 'package:tyba_app/widgets/painters/login_painter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  static const String routeName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ctrlEmail = TextEditingController();

  final ctrlPassword = TextEditingController();

  final focusPassword = FocusNode();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
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
                left: 0,
                bottom: size.height * 0.15,
                child: LeftBanner(
                  label: 'Registro',
                  onTap: () => Navigator.pushReplacementNamed(
                    context,
                    RegisterPage.routeName,
                  ),
                ),
              ),
              FormLogin(
                ctrlEmail: ctrlEmail,
                ctrlPassword: ctrlPassword,
                focusPassword: focusPassword,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  const FormLogin({
    Key? key,
    required this.ctrlEmail,
    required this.ctrlPassword,
    required this.focusPassword,
  }) : super(key: key);

  final TextEditingController ctrlEmail;
  final TextEditingController ctrlPassword;
  final FocusNode focusPassword;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Login',
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: size.height * .08),
          ContainerFieldsAuth(
            fields: [
              AuthTextField(
                hintText: 'Email',
                controller: ctrlEmail,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                onSubmitted: (_) => focusPassword.requestFocus(),
              ),
              Container(
                width: size.width,
                color: Colors.grey.withOpacity(0.5),
                height: 1,
              ),
              AuthTextField(
                obscureText: true,
                controller: ctrlPassword,
                hintText: "Password",
                prefixIcon: Icons.lock,
                focusNode: focusPassword,
                onSubmitted: (_) => {},
              ),
            ],
            onSubmit: () => onSubmitLogin(context),
            submitIconData: Icons.arrow_forward,
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Future onSubmitLogin(BuildContext context) async {
    String email = ctrlEmail.value.text;
    String password = ctrlPassword.value.text;
    //Validate fields
    String? errorText = ValidationsFields().validateFields([
      Field(
        typeField: TypeField.email,
        value: email,
        fieldName: "Email",
      ),
      Field(
        typeField: TypeField.password,
        value: password,
        fieldName: "Password",
      ),
    ]);
    if (errorText != null) {
      return showMessageAlert(
        context: context,
        title: 'Versify',
        message: errorText,
      );
    }
    if (!await NewtworkValidator.checkNetworkAndAlert(context)) return;

    final userBloc = BlocProvider.of<UserCubit>(context);
    final user = await userBloc.login(
      emailAddress: email,
      password: password,
    );
    if (user != null) {
      Navigator.pushNamedAndRemoveUntil(
          context, PlacesPage.routeName, (route) => false);
    }
  }
}
