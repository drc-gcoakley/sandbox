import {NgModule} from '@angular/core';
import {CommonModule} from '@angular/common';
import {BrowserModule} from '@angular/platform-browser';
import {HttpClientModule} from '@angular/common/http';
import {RouterModule} from '@angular/router';
import {StoreModule} from '@ngrx/store';
// Components
import {EcaFooterComponent} from './eca-footer/eca-footer.component';
import {EcaHeaderComponent} from './eca-header/eca-header.component';
import {EcaPortalAppContainerComponent} from './portal-container/portal-container.component';
import {EcaUnauthorizedComponent} from './unauthorized/unauthorized.component';
// Services
import {ConfigurationService} from './services/configuration.service';
import {ScriptLoaderService} from './services/script-loader.service';
import {SecurityService} from './services/security.service';
// State
import {initialState} from './state/initialState';
import {ecaReducers} from './state/eca.reducers';
import {RedirectOnUnauthorized} from './redirect-on-unauthorized';

/**
 *
 * This provides a Typescript, Angular 5 component that adds the javascript and HTML elements for
 * displaying the Insight, ECA Portal and interacting with it.
 *
 * It may be added to an application simply by including the module then adding the selector tag
 * ('eca-portal') to an html template. For any component that you want to display inside of the
 * portal (below the ECA Portal header and above the ECA Portal footer) should be have its 'outlet'
 * (target location) set the router-outlet named 'ecaPortal' which is defined in this module.
 * (In it's EcaPortaContainerComponent).
 *
 * Note that all components, services, reducers and the initial state objects are names that are
 * exported from this module. Though they can be renamed when imported, please, try to give them
 * names that are appropriate in that context, for example by prefixing them with 'Eca'.
 */
@NgModule({
  declarations: [
    EcaHeaderComponent, EcaFooterComponent, EcaUnauthorizedComponent, EcaPortalAppContainerComponent
  ],
  imports: [
    CommonModule, BrowserModule, HttpClientModule, RouterModule,
    StoreModule.forRoot(ecaReducers, {initialState: initialState})
  ],
  entryComponents: [EcaPortalAppContainerComponent],
  providers: [
    ConfigurationService, SecurityService, ScriptLoaderService, RedirectOnUnauthorized
  ],
  bootstrap: [],
  exports: [
    EcaPortalAppContainerComponent, EcaUnauthorizedComponent
  ]
})
export class EcaClientModule {
}
