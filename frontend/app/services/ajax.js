import AjaxService from 'ember-ajax/services/ajax';
import Ember from 'ember';

const { computed, inject } = Ember;

export default AjaxService.extend({
  session: inject.service('session'),
  namespace: '/api',

  headers: computed('session.data.authenticated.token', {
    get() {
      let headers = {
        Accept: 'application/vnd.api+json,application/json'
      };
      let token = this.get('session.data.authenticated.token');
      let ldap_uid = this.get('session.data.authenticated.ldap_uid');

      if (token && ldap_uid) {
        headers['api-token'] = `${token}`;
        headers['ldap-uid'] = `${ldap_uid}`;
      }
      return headers;
    }
  })
});
