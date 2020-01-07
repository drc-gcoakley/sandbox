import {NgModule} from '@angular/core';
import {RouterModule, Routes} from '@angular/router';
import {EcaUnauthorizedComponent} from './unauthorized/unauthorized.component';
import {EcaPortalAppContainerComponent} from './portal-container/portal-container.component';
import {RedirectOnUnauthorized} from './redirect-on-unauthorized';

const ecaClientRoutes: Routes = [
  {path: 'app', component: EcaPortalAppContainerComponent, canActivate: [RedirectOnUnauthorized]},
  {path: 'unauthorized', component: EcaUnauthorizedComponent},
  {path: '**', redirectTo: 'app'}, // fall-back / default / catch-all routing rule
];

@NgModule({
  imports: [],
  providers: [RedirectOnUnauthorized],
  exports: [RouterModule],
})
export class EcaClientRoutingModule {
}
