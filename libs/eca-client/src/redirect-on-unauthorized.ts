import {Injectable} from '@angular/core';
import {CanActivate, Router} from '@angular/router';
import {SecurityService} from './services/security.service';
// Explicit import of 'Observable' so that '.d.ts' files can be generated correctly.
import {Observable} from 'rxjs/Observable';

@Injectable()
export class RedirectOnUnauthorized implements CanActivate {

  constructor(private securityService: SecurityService, private router: Router) {
  }

  canActivate(): Observable<boolean> {
    return this.securityService.isUserLoggedIn().map((isLoggedIn) => {
      if (!isLoggedIn) {
        this.router.navigate(['unauthorized']);
      }
      return isLoggedIn;
    });
  }
}

e
