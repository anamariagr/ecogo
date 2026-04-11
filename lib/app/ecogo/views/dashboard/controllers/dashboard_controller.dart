import 'package:ecogo/app/ecogo/controllers/auth_controller.dart';
import 'package:ecogo/app/ecogo/controllers/user_controller.dart';
import 'package:ecogo/services/report_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:loading_overlay/loading_overlay.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final PanelController panelController = PanelController();
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final AuthController authController = Get.find();
  final isLoading = false.obs;
  final UserController userController = Get.put(UserController());
  final ReportService reportService = Get.find();


  // Variables reactivas
  var currentUser = Rx<GoogleSignInAccount?>(null);
  var userId =
      Rx<String?>(null); // Variable para almacenar el ID único del usuario

  var selectedIndex = 0.obs;
  var isAuthorized = false.obs;
  var typeOfContent = 1.obs;
  final storage = GetStorage(); // Instancia de GetStorage

  Future<void> handleSignOut() async {
    try {
      await _googleSignIn.signOut();
      currentUser.value = null;
      userId.value = null; // Limpia el ID al cerrar sesión
      isAuthorized.value = false;

      storage.write('isAuthorized', false);

      authController.logout();
     // Get.snackbar("Cierre de sesión", "Has cerrado sesión exitosamente.");
    } catch (error) {
      Get.snackbar("Error", "No se pudo cerrar la sesión.");
    }
  }

  @override
  void onInit() {
    super.onInit();
    _googleSignIn.onCurrentUserChanged
        .listen((GoogleSignInAccount? account) async {
      bool authorized = account != null;
      if (account != null && GetPlatform.isWeb) {
        isLoading.value = true;
        authorized = await _googleSignIn.canAccessScopes(['email']);
        isLoading.value = false;
      }
      await userController.fetchUser();

      currentUser.value = account;
      isAuthorized.value = authorized;
      userId.value = account?.id; // Guarda el ID único

      if (authorized) {
        panelController.close();
      }
    });
    _googleSignIn.signInSilently();
  }

  Future<void> handleSignIn() async {
    try {
      isLoading.value = true;

      await _googleSignIn.signIn();
      final account = await _googleSignIn.signIn();

      if (account != null) {
        await authController.loginOrRegister(
            account.email, account.id, account.displayName, account.photoUrl);
        if (authController.isAuthenticated.value) {
          currentUser.value = account; // Configura el usuario actual
          isAuthorized.value = true;

          storage.write('isAuthorized', true);

          await userController.fetchUser();
          userId.value = account.id;

          reportService.linkPendingReportsToUser();

        }
      }
    } catch (error) {
      print(error);
    } finally {
      isLoading.value = false;
    }
  }

  void onPageChanged(int index) {
    selectedIndex.value = index;
    pageController.jumpToPage(index); // Navega a la página seleccionada
  }
}
