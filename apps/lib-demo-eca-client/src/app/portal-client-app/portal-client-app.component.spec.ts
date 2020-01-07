import {async, ComponentFixture, TestBed} from '@angular/core/testing';

import {PortalClientAppComponent} from './portal-client-app.component';

describe('PortalClientAppComponent', () => {
  let component: PortalClientAppComponent;
  let fixture: ComponentFixture<PortalClientAppComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [PortalClientAppComponent]
    })
      .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(PortalClientAppComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
