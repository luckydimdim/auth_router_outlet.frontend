import 'dart:core';
import 'dart:html';

import 'package:angular2/platform/browser.dart';
import 'package:angular2/core.dart';
import 'package:angular2/src/core/reflection/reflection.dart';
import 'package:angular2/router.dart';
import 'package:angular2/platform/common.dart';

import 'package:alert/alert_component.dart';
import 'package:alert/alert_service.dart';

bool get isDebug =>
    (const String.fromEnvironment('PRODUCTION', defaultValue: 'false')) !=
    'true';

main() async {
  if (isDebug) {
    reflector.trackUsage();
  }

  ComponentRef ref = await bootstrap(AlertComponent, [
    ROUTER_PROVIDERS,
    const Provider(LocationStrategy, useClass: HashLocationStrategy),
    const Provider(AlertService),
  ]);

  var alertService = ref.injector.get(AlertService);

  querySelector('#show-danger')
    ..onClick.listen((_) => alertService.Danger('danger text'));

  querySelector('#show-success')
    ..onClick.listen((_) => alertService.Success('success text'));

  querySelector('#show-info')
    ..onClick.listen((_) => alertService.Info('info text'));

  querySelector('#show-warning')
    ..onClick.listen((_) => alertService.Warning('warning text'));

  if (isDebug) {
    print('Application in DebugMode');
    enableDebugTools(ref);
    print('Unused keys: ${reflector.listUnusedKeys()}');
  }
}
