## Puppet modules

This set of Puppet manifests and modules are currently being used to manage the OpenStack Project infrastructure. The main entry point is in _manifests/site.pp_.

Most of the modules are generally designed to be able to run either in Agent or Apply mode. The Puppet modules require Puppet 2.7 or greater, and the _site.pp_ manifest assumes the existence of hiera. See http://ci.openstack.org for more information.

### Documentation

The http://ci.openstack.org documentation comes from the git://git.openstack.org/openstack-infra/system-config repository named _docs/source_.

### Build documentation
    $ tox -evenv python setup.py build_sphinx
