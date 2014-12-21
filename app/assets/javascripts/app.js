//= require_self
//= require_tree ./app

angular.module('app', []).config(function($httpProvider) {
  // HTTP requests made from the latest version of Angular are not
  // recognized by the latest version of Rails as JSON API requests,
  // for two reasons:
  //
  // 1. Angular no longer declares that it is making an XHR request
  //    (https://github.com/angular/angular.js/issues/1004), and
  // 2. Rails deliberately violates the content-negotiation rules of the
  //    HTTP specification, interpreting Angular's default Accept header
  //    as an HTML request (https://github.com/rails/rails/issues/9940).
  //
  // To work around this, we configure Angular to use a custom Accept
  // header that satisfies Rails.
  $httpProvider.defaults.headers.common['Accept'] = 'application/json';
});
