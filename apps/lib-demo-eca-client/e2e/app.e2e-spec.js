"use strict";
Object.defineProperty(exports, "__esModule", {value: true});
var app_po_1 = require("./app.po");
describe('one-app App', function () {
  var page;
  beforeEach(function () {
    page = new app_po_1.AppPage();
  });
  it('should display welcome message', function () {
    page.navigateTo();
    expect(page.text()).toContain('app works!');
  });
});
//# sourceMappingURL=app.e2e-spec.js.map
