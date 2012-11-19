# Castronaut (https://secure.travis-ci.org/blake-education/castronaut.png)][Continuous Integration]

## Description

Castronaut is an server implementation for the CAS (version 2.0) protocol.  It
is currently a work in progress but should function properly with the latest
release of Restfult Auth.  More authentication adapters coming soon.

## Usage

@castronaut@

or

@castronaut -C /path/to/config@

## Support

* Database authentication with the restful authentication encryption routines.
* LDAP (openLDAP) annonymous bind only.  Authenticated bind comming soon.

## Configuration

Castronaut requires a configuration file to function.  Your configuration should be similar to the following:

     organization_name: Foo Bar Baz Industries, LLC Inc. A division of Holdings Co.

     environment: development

     server_port: 4567

     log_directory: log

     log_level: Logger::DEBUG

     ssl_enabled: false

     cas_database:
      adapter: sqlite3
      database: db/cas.db
      timeout: 5000

     cas_adapter:
      adapter: database
      site_key: 03523your093023site0985225key098290here9
      digest_stretches: 10
      database:
        adapter: sqlite3
        database: db/cas_adapter.db
        timeout: 5000

 Uncomment these to enable authentication callbacks
 callbacks:

    on_authentication_success: http://example.com/authentication/success
    on_authentication_failed: http://example.com/authentication/failed

    extra_ui_actions:
        'Forgot Password': http://example.com/

### or if you are using LDAP

 Use this example if you are using LDAP as your authentication source

     cas_adapter:
      adapter: ldap
      host: localhost
      port: 389
      prefix: cn=
      base: dc=example, dc=com
