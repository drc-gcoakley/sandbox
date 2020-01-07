import {inject, TestBed} from '@angular/core/testing';

import {ConfigurationService} from './configuration.service';
import {HttpClientTestingModule, HttpTestingController} from '@angular/common/http/testing';
import {ecaReducers} from '../state/eca.reducers';
import {Store, StoreModule} from '@ngrx/store';

describe('ConfigurationService', () => {
  const initialState = {
    config: {},
  };

  beforeEach(() => {
    TestBed.configureTestingModule({
      imports: [
        StoreModule.forRoot(ecaReducers, {initialState}),
        HttpClientTestingModule,
      ],
      providers: [
        ConfigurationService,
      ],
    });
  });

  it('should retrieve config.json', inject(
    [ConfigurationService, HttpTestingController],
    (service: ConfigurationService, httpMock: HttpTestingController) => {

      service.consumeConfigJson();
      httpMock.expectOne('config.json');
    }));

  /* Sometimes this first test of the store will fail if you are doing other things on your
   * computer while the unit tests are executing.
   */
  it('should dispatch received json to the store', (done) => {
    inject([ConfigurationService, HttpTestingController, Store],
      (service: ConfigurationService, httpMock: HttpTestingController, store: Store<any>) => {

        // Set properties of an IConfig object needed for these tests.
        const expectedConfig = {
          client: 'MARS',
          portalHeaderLibUrl: 'sarlac.pit',
          portalAppApiUrl: 'mars.rover.of.awesome',
        };

        service.consumeConfigJson();

        httpMock.expectOne('config.json').flush(expectedConfig);

        store.select('config').subscribe((config) => {
          expect(config).toEqual(expectedConfig);
          done();
        });

      })();
  });
});
