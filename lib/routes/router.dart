
import 'package:get/get.dart';
import 'package:wiespl/drawer/navigation_drawer.dart';
import 'package:wiespl/main_screen.dart';
import 'package:wiespl/screen/attachment.dart';
import 'package:wiespl/screen/auth/login.dart';
import 'package:wiespl/screen/client_home_page.dart';
import 'package:wiespl/screen/control_panel.dart';
import 'package:wiespl/screen/faq.dart';
import 'package:wiespl/screen/home_page.dart';
import 'package:wiespl/screen/management_open_request_details.dart';
import 'package:wiespl/screen/management_plc_service_request.dart';
import 'package:wiespl/screen/notification_page.dart';
import 'package:wiespl/screen/open_request.dart';
import 'package:wiespl/screen/open_request_details.dart';
import 'package:wiespl/screen/open_request_start.dart';
import 'package:wiespl/screen/privacy_policy.dart';
import 'package:wiespl/screen/run_time_history.dart';
import 'package:wiespl/screen/service_error_from.dart';
import 'package:wiespl/screen/service_error_list.dart';
import 'package:wiespl/screen/service_error_request.dart';
import 'package:wiespl/screen/service_request.dart';
import 'package:wiespl/screen/service_request_plc.dart';
import 'package:wiespl/screen/service_request_plc_details.dart';
import 'package:wiespl/screen/splash.dart';
import 'package:wiespl/screen/system_details.dart';
import 'package:wiespl/screen/system_list_details.dart';
import 'package:wiespl/screen/technician_home_page.dart';
import 'package:wiespl/screen/terms_conditions.dart';
import 'package:wiespl/screen/user_activity.dart';

import '../model/client/fault_list.dart';
import '../screen/amc_page.dart';
import '../screen/image_slider.dart';
import '../screen/management/client_generated_request_list.dart';
import '../screen/management/management_general_list.dart';
import '../screen/management/management_request_list.dart';
import '../screen/technician_history_details.dart';
import '../screen/technician_history_plc.dart';


class Router {
  static final route = [
    GetPage(name: '/splash', page: () => const Splash()),
    GetPage(name: '/login', page: () => const Login()),
    GetPage(name: '/navigation_drawer', page: () => NavigationDrawer()),
    GetPage(name: '/main_screen', page: () => MainScreen()),
    GetPage(name: '/home_page', page: () => const HomePage()),
    GetPage(name: '/open_request', page: () => const OpenRequest()),
    GetPage(name: '/open_request_start', page: () => const OpenRequestStart()),
    GetPage(name: '/open_request_details', page: () => const OpenRequestDetails()),
    GetPage(name: '/management_open_request_details', page: () => const ManagementOpenRequestDetails()),
    GetPage(name: '/management_plc_service_request', page: () => const ManagementPlcServiceRequest()),
    GetPage(name: '/service_request', page: () => const ServiceRequest()),
    GetPage(name: '/service_request_plc_details', page: () => const ServiceRequestPlcDetails()),
    GetPage(name: '/client_home_page', page: () => const ClientHomePage()),
    GetPage(name: '/system_details', page: () => const SystemDetails()),
    GetPage(name: '/control_panel', page: () => const ControlPanel()),
    GetPage(name: '/run_time_history', page: () => const RunTimeHistory()),
    GetPage(name: '/technician_home_page', page: () => const TechnicianHomePage()),
    GetPage(name: '/terms_conditions', page: () => const TermsConditions()),
    GetPage(name: '/privacy_policy', page: () => const PrivacyPolicy()),
    GetPage(name: '/faq', page: () => const FAQ()),
    GetPage(name: '/user_activity', page: () => const UserActivity()),
    GetPage(name: '/notification', page: () => const NotificationPage()),
    GetPage(name: '/service_error_from', page: () => const ServiceErrorFrom()),
    GetPage(name: '/service_error_request', page: () => const ServiceErrorRequest()),
    GetPage(name: '/system_list_details', page: () => const SystemListDetails()),
    GetPage(name: '/service_request_plc', page: () => const ServiceRequestPlc()),
    GetPage(name: '/service_error_list', page: () => const ServiceErrorList()),
    GetPage(name: '/attachment', page: () => const Attachment()),
    GetPage(name: '/technician_history_details', page: () => const TechnicianHistoryDetails()),
    GetPage(name: '/management_request_list', page: () => const ManagementRequestList()),
    GetPage(name: '/management_general_list', page: () => const ManagementGeneralList()),
    GetPage(name: '/client_generated_request_list', page: () => const ClientGeneratedRequestList()),
    GetPage(name: '/amc_page', page: () => const AMCPage()),
    GetPage(name: '/image_slider', page: () => const ImageSlider()),
    GetPage(name: '/fault_list', page: () => const FaultList()),
  ];
}
