import 'package:bitel_ventas/main/ui/main/drawer/manage_contact/create/view_item/document_scan/scan_model/customer_ce_model.dart';

import 'customer_dni_model.dart';
import 'customer_pp_model.dart';

class CustomerScanModel {
  CustomerDNIModel dniModel = CustomerDNIModel();
  CustomerCEModel ceModel = CustomerCEModel();
  CustomerPPModel ppModel = CustomerPPModel();
  dynamic getCustomerScan(String type) {
    if (type == 'PP') {
      return ppModel;
    } else if (type == 'CE') {
      return ceModel;
    } else {
      return dniModel;
    }
  }
}
