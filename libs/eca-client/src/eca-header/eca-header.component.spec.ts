import {async, ComponentFixture, TestBed} from '@angular/core/testing';
import {StoreModule} from '@ngrx/store';

import {EcaHeaderComponent} from './eca-header.component';
import {ecaReducers} from '../state/eca.reducers';
import {ScriptLoaderService} from '../services/script-loader.service';

let portalHeader;

const initialState = {
  config: {
    client: 'TABE',
    portalHeaderLibUrl: 'fake.portal.header.url',
    portalAppApiUrl: 'fake.web.api.url',
  },
  token: 'SOMETOKEN',
};

class ScriptLoaderServiceMock {
  load(url) {
    console.log(`eca-header mock pretending to load ${url}`);
    if (url.match(/header/)) {
      portalHeader = window['ECA_PORTAL_HEADER'] = {
        init: jasmine.createSpy('headerInit'),
      };
    }
    return Promise.resolve();
  }
}

describe('EcaHeaderComponent', () => {
  let component: EcaHeaderComponent;
  let fixture: ComponentFixture<EcaHeaderComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      imports: [
        StoreModule.forRoot(ecaReducers, {initialState}),
      ],
      declarations: [
        EcaHeaderComponent,
      ],
      providers: [
        {provide: ScriptLoaderService, useClass: ScriptLoaderServiceMock},
      ],
    })
      .compileComponents();
  }));

  beforeEach((done) => {
    fixture = TestBed.createComponent(EcaHeaderComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
    fixture.whenStable().then(done);
  });

  it('should create header', () => {
    expect(component).toBeTruthy();
  });

  it('should initialize the ECA Portal Navigation Header', () => {
    expect(portalHeader.init)
      .toHaveBeenCalledWith({
        clientAbbreviation: initialState.config.client,
        token: initialState.token,
      });
  });

});
