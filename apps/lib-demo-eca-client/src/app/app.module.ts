import {NgModule} from '@angular/core';
import {BrowserModule} from '@angular/platform-browser';
import {NxModule} from '@nrwl/nx';
import {RouterModule} from '@angular/router';
import {EcaClientModule} from '@eca/client-lib';
import {AppComponent} from './app.component';
import {PortalClientAppComponent} from './portal-client-app/portal-client-app.component';

@NgModule({
  imports: [
    BrowserModule,
    NxModule.forRoot(),
    EcaClientModule,
    RouterModule,
    RouterModule.forRoot([
      {path: '', pathMatch: 'full', component: PortalClientAppComponent, outlet: 'ecaPortal'}
    ]),
  ],
  declarations: [AppComponent, PortalClientAppComponent],
  bootstrap: [AppComponent]
})
export class AppModule {
}
