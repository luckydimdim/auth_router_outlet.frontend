import 'dart:async';

import 'package:angular2/core.dart';
import 'package:angular2/router.dart';

import 'package:auth/auth_service.dart';

@Directive(
    selector: 'router-outlet'
)
class AuthRouterOutlet extends RouterOutlet {

  Router _pr;
  AuthenticationService _authenticationService;


  AuthRouterOutlet(ViewContainerRef elRef, ComponentResolver res,
      Router _parentRouter, @Attribute("name") String nameAttr, this._authenticationService)
      : super(elRef, res, _parentRouter, nameAttr) {
    _pr = _parentRouter;

  }

  bool _canActivate(String url) {
    return url == _authenticationService.authPath || _authenticationService.isAuth();
  }

  @override
  Future<dynamic> activate(ComponentInstruction nextInstruction) {
    if (!_canActivate(nextInstruction.urlPath)) {
      var path = _authenticationService.authPath + '?url=${nextInstruction.urlPath}';
      _pr.navigateByUrl(path);
    }

    return super.activate(nextInstruction);
  }


}