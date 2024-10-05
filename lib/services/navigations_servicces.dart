import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class NavigationService {
  //Chuyển sang màn mới, go back có thể reset lại màn cũ => Nhưng không hiển thị bottom tab:
  Future<void> pushRouteNamed(String routeName, {Object? arguments}) {
    return navigator?.pushNamed(routeName, arguments: arguments) ??
        Future.value();
  }

  //Chuyển sang màn mới nhưng thêm 1 màn hình đè lên trên stack => Nhưng vẫn có bottom tab:
  //Nhớ khi sử dụng: context mà là MultiBlocProvider thì phải dùng providers(params) còn không truyền widget screen() thì thêm agrument tránh render.
  Future<void> navigate(BuildContext context, Widget routeName,
      {Object? arguments}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

//Chuyển sang 1 màn mới và reset route hiện tại:
  Future<void> navigateAndResetRoute(BuildContext context, Widget routeName,
      {Object? arguments}) {
    return Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
        settings: RouteSettings(arguments: arguments),
      ),
      (Route<dynamic> route) =>
          false, // Điều kiện để loại bỏ tất cả các màn hình trước đó
    );
  }

//Chuyển sang 1 màn hình mới và xoá màn hình hiện tại:
  Future<void> navigateAndRemoveCurrentScreen(
      BuildContext context, Widget routeName,
      {Object? arguments}) {
    return Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  //Xoá màn hình hiện tại nhưng không làm mất các màn hình đã đi qua:
  Future<void> navigateBack(BuildContext context, {Object? result}) {
    return Navigator.of(context).maybePop(result);
  }

//Chuyển sang màn mới với bloc provider trong một contextProvider =>
//Tránh navigate khi truyền context vào nằm khác bloc cubit gây lỗi:
  Future<void> navigateWithBlocProvider<
      CubitProvider extends Cubit<StateProvider>, StateProvider>({
    required BuildContext context,
    required Widget Function(BuildContext context, StateProvider state) builder,
    required CubitProvider Function(BuildContext context) createCubit,
    Object? arguments,
  }) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: createCubit,
          child: BlocBuilder<CubitProvider, StateProvider>(
            builder: builder,
          ),
        ),
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  //Chuyển sang màn mới sau khi thành công thực hiện 1 actions:
  Future<void> navigateAndPerformAction(BuildContext context, Widget routeName,
      {Object? arguments, Future<void> Function()? actionOnComplete}) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routeName,
        settings: RouteSettings(arguments: arguments),
      ),
    ).then((_) {
      if (actionOnComplete != null) {
        return actionOnComplete();
      }
    });
  }

  // Replace current screen with a new screen with optional data
  Future<void> replace(String routeName, {Object? arguments}) {
    return navigator?.pushReplacementNamed(routeName, arguments: arguments) ??
        Future.value();
  }

  // Go back to the previous screen
  void goBack() {
    return navigator?.pop();
  }

  // Navigate and clear the stack to a new screen with optional data
  Future<void> reset(String routeName, {Object? arguments}) {
    return navigator?.pushNamedAndRemoveUntil(
          routeName,
          (route) => false,
          arguments: arguments,
        ) ??
        Future.value();
  }
}
