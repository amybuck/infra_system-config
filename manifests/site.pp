#
# Top-level variables
#
# There must not be any whitespace between this comment and the variables or
# in between any two variables in order for them to be correctly parsed and
# passed around in test.sh
#
$elasticsearch_nodes = [
  'elasticsearch02.openstack.org',
  'elasticsearch03.openstack.org',
  'elasticsearch04.openstack.org',
  'elasticsearch05.openstack.org',
  'elasticsearch06.openstack.org',
  'elasticsearch07.openstack.org',
]
$elasticsearch_clients = [
  'logstash.openstack.org',
  'logstash-worker01.openstack.org',
  'logstash-worker02.openstack.org',
  'logstash-worker03.openstack.org',
  'logstash-worker04.openstack.org',
  'logstash-worker05.openstack.org',
  'logstash-worker06.openstack.org',
  'logstash-worker07.openstack.org',
  'logstash-worker08.openstack.org',
  'logstash-worker09.openstack.org',
  'logstash-worker10.openstack.org',
  'logstash-worker11.openstack.org',
  'logstash-worker12.openstack.org',
  'logstash-worker13.openstack.org',
  'logstash-worker14.openstack.org',
  'logstash-worker15.openstack.org',
  'logstash-worker16.openstack.org',
  'logstash-worker17.openstack.org',
  'logstash-worker18.openstack.org',
  'logstash-worker19.openstack.org',
  'logstash-worker20.openstack.org',
  'subunit-worker01.openstack.org',
]

#
# Default: should at least behave like an openstack server
#
node default {
  class { 'openstack_project::server':
    sysadmins => hiera('sysadmins', []),
  }
}

node 'analytics.openswitch.net' {
  class { 'openstack_project::analytics':
    sysadmins               => hiera('sysadmins', []),
    ssl_cert_file_contents  => hiera('analytics_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('analytics_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('analytics_ssl_chain_file_contents', 'XXX'),
  }
}


#
# Long lived servers:
#
# Node-OS: precise
node 'review.openswitch.net', 'review-aws.openswitch.net' {
  class { 'openstack_project::review':
    project_config_repo                 => 'https://git.openswitch.net/infra/project-config',
    github_oauth_token                  => hiera('gerrit_github_token', 'XXX'),
    github_project_username             => hiera('github_project_username', 'username'),
    github_project_password             => hiera('github_project_password', 'XXX'),
    mysql_host                          => hiera('gerrit_mysql_host', 'localhost'),
    mysql_password                      => hiera('gerrit_mysql_password', 'XXX'),
    email_private_key                   => hiera('gerrit_email_private_key', 'XXX'),
    gerritbot_password                  => hiera('gerrit_gerritbot_password', 'XXX'),
    gerritbot_ssh_rsa_key_contents      => hiera('gerritbot_ssh_rsa_key_contents', 'XXX'),
    gerritbot_ssh_rsa_pubkey_contents   => hiera('gerritbot_ssh_rsa_pubkey_contents', 'XXX'),
    ssl_cert_file_contents              => hiera('gerrit_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents               => hiera('gerrit_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents             => hiera('gerrit_ssl_chain_file_contents', 'XXX'),
    ssh_dsa_key_contents                => hiera('gerrit_ssh_dsa_key_contents', 'XXX'),
    ssh_dsa_pubkey_contents             => hiera('gerrit_ssh_dsa_pubkey_contents', 'XXX'),
    ssh_rsa_key_contents                => hiera('gerrit_ssh_rsa_key_contents', 'XXX'),
    ssh_rsa_pubkey_contents             => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_project_rsa_key_contents        => hiera('gerrit_project_ssh_rsa_key_contents', 'XXX'),
    ssh_project_rsa_pubkey_contents     => hiera('gerrit_project_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_welcome_rsa_key_contents        => hiera('welcome_message_gerrit_ssh_private_key', 'XXX'),
    ssh_welcome_rsa_pubkey_contents     => hiera('welcome_message_gerrit_ssh_public_key', 'XXX'),
    ssh_replication_rsa_key_contents    => hiera('gerrit_replication_ssh_rsa_key_contents', 'XXX'),
    ssh_replication_rsa_pubkey_contents => hiera('gerrit_replication_ssh_rsa_pubkey_contents', 'XXX'),
    lp_sync_consumer_key                => hiera('gerrit_lp_consumer_key', 'XXX'),
    lp_sync_token                       => hiera('gerrit_lp_access_token', 'XXX'),
    lp_sync_secret                      => hiera('gerrit_lp_access_secret', 'XXX'),
    contactstore_appsec                 => hiera('gerrit_contactstore_appsec', 'XXX'),
    contactstore_pubkey                 => hiera('gerrit_contactstore_pubkey', 'XXX'),
    sysadmins                           => hiera('sysadmins', []),
    swift_username                      => hiera('swift_store_user', 'username'),
    swift_password                      => hiera('swift_store_key', 'XXX'),
    smtpserver                          => 'email-smtp.us-west-2.amazonaws.com',
    smtpuser                            => hiera('smtpuser', 'XXX'),
    smtppass                            => hiera('smtppass', 'XXX'),
    oauth_github_client_id              => hiera('gerrit_github_client_id', 'XXX'),
    oauth_github_client_secret          => hiera('gerrit_github_client_secret', 'XXX'),
  }
  class { 'gerrit::mysql':
    mysql_root_password                 => hiera('gerrit_mysql_root_password', 'XXX'),
    database_name                       => 'reviewdb',
    database_user                       => 'gerrit2',
    database_password                   => hiera('gerrit_mysql_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'review-dev.openswitch.net' {
  class { 'openstack_project::review_dev':
    project_config_repo             => 'https://git.openswitch.net/infra/project-config',
    #github_oauth_token              => hiera('gerrit_dev_github_token', 'XXX'),
    #github_project_username         => hiera('github_dev_project_username', 'username'),
    #github_project_password         => hiera('github_dev_project_password', 'XXX'),
    mysql_host                      => hiera('gerrit_dev_mysql_host', 'localhost'),
    mysql_password                  => hiera('gerrit_dev_mysql_password', 'XXX'),
    #email_private_key               => hiera('gerrit_dev_email_private_key', 'XXX'),
    ssl_cert_file_contents          => hiera('gerrit_dev_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents           => hiera('gerrit_dev_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents         => hiera('gerrit_dev_ssl_chain_file_contents', 'XXX'),
    contactstore_appsec             => hiera('gerrit_dev_contactstore_appsec', 'XXX'),
    contactstore_pubkey             => hiera('gerrit_dev_contactstore_pubkey', 'XXX'),
    ssh_dsa_key_contents            => hiera('gerrit_dev_ssh_dsa_key_contents', 'XXX'),
    ssh_dsa_pubkey_contents         => hiera('gerrit_dev_ssh_dsa_pubkey_contents', 'XXX'),
    ssh_rsa_key_contents            => hiera('gerrit_dev_ssh_rsa_key_contents', 'XXX'),
    ssh_rsa_pubkey_contents         => hiera('gerrit_dev_ssh_rsa_pubkey_contents', 'XXX'),
    ssh_project_rsa_key_contents    => hiera('gerrit_dev_project_ssh_rsa_key_contents', 'XXX'),
    ssh_project_rsa_pubkey_contents => hiera('gerrit_dev_project_ssh_rsa_pubkey_contents', 'XXX'),
    lp_sync_consumer_key            => hiera('gerrit_dev_lp_consumer_key', 'XXX'),
    lp_sync_token                   => hiera('gerrit_dev_lp_access_token', 'XXX'),
    lp_sync_secret                  => hiera('gerrit_dev_lp_access_secret', 'XXX'),
    sysadmins                       => hiera('sysadmins', []),
    smtpserver                      => 'email-smtp.us-west-2.amazonaws.com',
    smtpuser                        => hiera('smtpuser', 'XXX'),
    smtppass                        => hiera('smtppass', 'XXX'),
    oauth_github_client_id          => hiera('gerrit_dev_github_client_id', 'XXX'),
    oauth_github_client_secret      => hiera('gerrit_dev_github_client_secret', 'XXX'),
  }
  class { 'gerrit::mysql':
    mysql_root_password                 => hiera('gerrit_dev_mysql_root_password', 'XXX'),
    database_name                       => 'reviewdb',
    database_user                       => 'gerrit2',
    database_password                   => hiera('gerrit_dev_mysql_password', 'XXX'),
  }
}

# Node-OS: precise
node 'jenkins.openswitch.net' {
  class { 'openstack_project::jenkins':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    jenkins_jobs_password   => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file_contents  => hiera('jenkins_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('jenkins_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('jenkins_ssl_chain_file_contents', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
#    zmq_event_receivers     => ['logstash.openstack.org',
#                                'nodepool.openstack.org',
#    ],
  }
}



# Node-OS: precise
node /^jenkins\d+\.openswitch\.net$/ {
  class { 'openstack_project::jenkins':
    jenkins_jobs_password   => hiera('jenkins_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file          => '',
    sysadmins               => hiera('sysadmins', []),
#    zmq_event_receivers     => ['logstash.openstack.org',
#                                'nodepool.openstack.org',
#    ],
  }
}

# Node-OS: precise
node 'jenkins-dev.openswitch.net' {
  class { 'openstack_project::jenkins_dev':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    jenkins_ssh_private_key  => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    mysql_root_password      => hiera('gerrit_dev_mysql_root_password', 'XXX'),
    mysql_password           => hiera('gerrit_dev_mysql_password', 'XXX'),
    jenkins_jobs_password   => hiera('jenkins_dev_jobs_password', 'XXX'),
    ssl_cert_file_contents   => hiera('jenkins_dev_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents    => hiera('jenkins_dev_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents  => hiera('jenkins_dev_ssl_chain_file_contents', 'XXX'),
    #ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    #ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    sysadmins                => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node /^jenkins\d+\-dev.openswitch\.net$/ {
  class { 'openstack_project::jenkins':
    jenkins_jobs_password   => hiera('jenkins_dev_jobs_password', 'XXX'),
    jenkins_ssh_private_key => hiera('jenkins_dev_ssh_private_key_contents', 'XXX'),
    ssl_cert_file           => '/etc/ssl/certs/ssl-cert-snakeoil.pem',
    ssl_key_file            => '/etc/ssl/private/ssl-cert-snakeoil.key',
    ssl_chain_file          => '',
    sysadmins               => hiera('sysadmins', []),
#    zmq_event_receivers     => ['logstash.openstack.org',
#                                'nodepool.openstack.org',
#    ],
  }
}

# Node-OS: precise
node 'cacti.openstack.org' {
  include openstack_project::ssl_cert_check
  class { 'openstack_project::cacti':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'puppetmaster.openswitch.net' {
  class { 'openstack_project::puppetmaster':
    root_rsa_key => hiera('puppetmaster_root_rsa_key', 'XXX'),
    sysadmins    => hiera('sysadmins', []),
    version      => '3.6.',
  }
}

# Node-OS: precise
node 'puppetdb.openswitch.net' {
  class { 'openstack_project::puppetdb':
    sysadmins => hiera('sysadmins', []),
  }
}

node 'ticket.openswitch.net' {
  include openstack_project::ticket
}

# Node-OS: precise
node 'graphite.openstack.org' {
  class { 'openstack_project::graphite':
    sysadmins               => hiera('sysadmins', []),
    graphite_admin_user     => hiera('graphite_admin_user', 'username'),
    graphite_admin_email    => hiera('graphite_admin_email', 'email@example.com'),
    graphite_admin_password => hiera('graphite_admin_password', 'XXX'),
    statsd_hosts            => ['logstash.openstack.org',
                                'nodepool.openstack.org',
                                'zuul.openstack.org'],
  }
}

# Node-OS: precise
node 'groups.openstack.org' {
  class { 'openstack_project::groups':
    sysadmins                    => hiera('sysadmins', []),
    site_admin_password          => hiera('groups_site_admin_password', 'XXX'),
    site_mysql_host              => hiera('groups_site_mysql_host', 'localhost'),
    site_mysql_password          => hiera('groups_site_mysql_password', 'XXX'),
    conf_cron_key                => hiera('groups_conf_cron_key', 'XXX'),
    site_ssl_cert_file_contents  => hiera('groups_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('groups_site_ssl_key_file_contents', undef),
    site_ssl_chain_file_contents => hiera('groups_site_ssl_chain_file_contents', undef),
  }
}

# Node-OS: precise
node 'groups-dev.openstack.org' {
  class { 'openstack_project::groups_dev':
    sysadmins                    => hiera('sysadmins', []),
    site_admin_password          => hiera('groups_dev_site_admin_password', 'XXX'),
    site_mysql_host              => hiera('groups_dev_site_mysql_host', 'localhost'),
    site_mysql_password          => hiera('groups_dev_site_mysql_password', 'XXX'),
    conf_cron_key                => hiera('groups_dev_conf_cron_key', 'XXX'),
    site_ssl_cert_file_contents  => hiera('groups_dev_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('groups_dev_site_ssl_key_file_contents', undef),
    site_ssl_cert_file           => '/etc/ssl/certs/groups-dev.openstack.org.pem',
    site_ssl_key_file            => '/etc/ssl/private/groups-dev.openstack.org.key',
  }
}

# Node-OS: precise
node 'lists.openswitch.net' {
  class { 'openstack_project::lists':
    listadmins   => hiera('listadmins', []),
    listpassword => hiera('listpassword', 'XXX'),
    smtpserver   => 'email-smtp.us-west-2.amazonaws.com',
    smtpuser     => hiera('smtpuser', 'XXX'),
    smtppass     => hiera('smtppass', 'XXX'),
  }
}

# Node-OS: precise
node 'paste.openstack.org' {
  class { 'openstack_project::paste':
    db_password         => hiera('paste_db_password', 'XXX'),
    mysql_root_password => hiera('paste_mysql_root_password', 'XXX'),
    sysadmins           => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'planet.openstack.org' {
  class { 'openstack_project::planet':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'eavesdrop.openswitch.net' {
  class { 'openstack_project::eavesdrop':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    nickpass                => hiera('openswitch_meetbot_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
#    statusbot_nick          => hiera('statusbot_nick', 'username'),
#    statusbot_password      => hiera('statusbot_nick_password', 'XXX'),
    statusbot_server        => 'chat.freenode.net',
#    statusbot_channels      => 'edeploy',
#    statusbot_auth_nicks    => '',
#    statusbot_wiki_user     => hiera('statusbot_wiki_username', 'username'),
#    statusbot_wiki_password => hiera('statusbot_wiki_password', 'XXX'),
#    statusbot_wiki_url      => 'https://wiki.openstack.org/w/api.php',
#    statusbot_wiki_pageid   => '1781',
    accessbot_nick          => hiera('accessbot_nick', 'username'),
    accessbot_password      => hiera('accessbot_nick_password', 'XXX'),
  }
}

# Node-OS: precise
node 'etherpad.openstack.org' {
  class { 'openstack_project::etherpad':
    ssl_cert_file_contents  => hiera('etherpad_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('etherpad_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('etherpad_ssl_chain_file_contents', 'XXX'),
    mysql_host              => hiera('etherpad_db_host', 'localhost'),
    mysql_user              => hiera('etherpad_db_user', 'username'),
    mysql_password          => hiera('etherpad_db_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'etherpad-dev.openstack.org' {
  class { 'openstack_project::etherpad_dev':
    mysql_host          => hiera('etherpad-dev_db_host', 'localhost'),
    mysql_user          => hiera('etherpad-dev_db_user', 'username'),
    mysql_password      => hiera('etherpad-dev_db_password', 'XXX'),
    sysadmins           => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'wiki.openswitch.net' {
  class { 'openstack_project::wiki':
    mysql_root_password     => hiera('wiki_db_password', 'XXX'),
    sysadmins               => hiera('sysadmins', []),
    ssl_cert_file_contents  => hiera('wiki_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('wiki_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('wiki_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'logstash.openstack.org' {
  class { 'openstack_project::logstash':
    sysadmins               => hiera('sysadmins', []),
    elasticsearch_nodes     => $elasticsearch_nodes,
    gearman_workers         => $elasticsearch_clients,
    discover_nodes          => [
      'elasticsearch02.openstack.org:9200',
      'elasticsearch03.openstack.org:9200',
      'elasticsearch04.openstack.org:9200',
      'elasticsearch05.openstack.org:9200',
      'elasticsearch06.openstack.org:9200',
      'elasticsearch07.openstack.org:9200',
    ],
    subunit2sql_db_host     => hiera('subunit2sql_db_host', ''),
    subunit2sql_db_pass     => hiera('subunit2sql_db_password', ''),
  }
}

# Node-OS: precise
node /^logstash-worker\d+\.openstack\.org$/ {
  class { 'openstack_project::logstash_worker':
    sysadmins             => hiera('sysadmins', []),
    elasticsearch_nodes   => $elasticsearch_nodes,
    elasticsearch_clients => $elasticsearch_clients,
    discover_node         => 'elasticsearch02.openstack.org',
  }
}

# Node-OS: trusty
node /^subunit-worker\d+\.openstack\.org$/ {
  class { 'openstack_project::subunit_worker':
    sysadmins             => hiera('sysadmins', []),
    subunit2sql_db_host => hiera('subunit2sql_db_host', ''),
    subunit2sql_db_pass => hiera('subunit2sql_db_password', ''),
  }
}

# Node-OS: precise
node /^elasticsearch0[1-7]\.openstack\.org$/ {
  class { 'openstack_project::elasticsearch_node':
    sysadmins             => hiera('sysadmins', []),
    elasticsearch_nodes   => $elasticsearch_nodes,
    elasticsearch_clients => $elasticsearch_clients,
    discover_nodes        => $elasticsearch_nodes,
  }
}

# CentOS machines to load balance git access.
# Node-OS: centos6
node 'git.openswitch.net' {
  class { 'openstack_project::git':
    sysadmins               => hiera('sysadmins', []),
    balancer_member_names   => [
      'git03.openswitch.net',
      'git04.openswitch.net',
    ],
    balancer_member_ips     => [
      '52.26.242.129',
      '52.34.28.108',
    ],
  }
}

# CentOS machines to run cgit and git daemon. Will be
# load balanced by git.openstack.org.
# Node-OS: centos6
node /^git\d+\.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::git_backend':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    vhost_name              => 'git.openswitch.net',
    sysadmins               => hiera('sysadmins', []),
    git_gerrit_ssh_key      => hiera('gerrit_replication_ssh_rsa_pubkey_contents', 'XXX'),
    ssl_cert_file_contents  => hiera('git_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('git_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('git_ssl_chain_file_contents', 'XXX'),
    behind_proxy            => true,
  }
}

# Machines in each region to run PyPI mirrors.
# Node-OS: precise
node /^pypi\..*\.openstack\.org$/ {
  class { 'openstack_project::pypi':
    sysadmins               => hiera('sysadmins', []),
  }
}

# A machine to run ODSREG in preparation for summits.
# Node-OS: precise
node 'summit.openstack.org' {
  class { 'openstack_project::summit':
    sysadmins => hiera('sysadmins', []),
  }
}

# A machine to run Storyboard
# Node-OS: precise
node 'storyboard.openstack.org' {
  class { 'openstack_project::storyboard':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    sysadmins               => hiera('sysadmins', []),
    mysql_host              => hiera('storyboard_db_host', 'localhost'),
    mysql_user              => hiera('storyboard_db_user', 'username'),
    mysql_password          => hiera('storyboard_db_password', 'XXX'),
    rabbitmq_user           => hiera('storyboard_rabbit_user', 'username'),
    rabbitmq_password       => hiera('storyboard_rabbit_password', 'XXX'),
    ssl_cert_file_contents  => hiera('storyboard_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('storyboard_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('storyboard_ssl_chain_file_contents', 'XXX')
  }
}

# A machine to serve static content.
# Node-OS: precise
node 'static.openswitch.net' {
  class { 'openstack_project::static':
    project_config_repo     => 'https://git.openswitch.net/infra/project-config',
    sysadmins               => hiera('sysadmins', []),
    ssl_cert_file_contents  => hiera('static_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('static_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('static_ssl_chain_file_contents', 'XXX')
  }
}


# A machine to serve various project status updates.
# Node-OS: precise
node 'status.openstack.org' {
  class { 'openstack_project::status':
    sysadmins                     => hiera('sysadmins', []),
    gerrit_host                   => 'review.openstack.org',
    gerrit_ssh_host_key           => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_public_key      => hiera('reviewday_rsa_pubkey_contents', 'XXX'),
    reviewday_ssh_private_key     => hiera('reviewday_rsa_key_contents', 'XXX'),
    releasestatus_ssh_public_key  => hiera('releasestatus_rsa_pubkey_contents', 'XXX'),
    releasestatus_ssh_private_key => hiera('releasestatus_rsa_key_contents', 'XXX'),
    recheck_ssh_public_key        => hiera('elastic-recheck_gerrit_ssh_public_key', 'XXX'),
    recheck_ssh_private_key       => hiera('elastic-recheck_gerrit_ssh_private_key', 'XXX'),
    recheck_bot_nick              => 'openstackrecheck',
    recheck_bot_passwd            => hiera('elastic-recheck_ircbot_password', 'XXX'),
  }
}

# Node-OS: trusty
node 'nodepool.openstack.org' {
  class { 'openstack_project::nodepool_prod':
    project_config_repo      => 'https://git.openswitch.net/infra/project-config',
    mysql_password           => hiera('nodepool_mysql_password', 'XXX'),
    mysql_root_password      => hiera('nodepool_mysql_root_password', 'XXX'),
    nodepool_ssh_private_key => hiera('jenkins_ssh_private_key_contents', 'XXX'),
    sysadmins                => hiera('sysadmins', []),
    statsd_host              => 'graphite.openstack.org',
    jenkins_api_user         => hiera('jenkins_api_user', 'username'),
    jenkins_api_key          => hiera('jenkins_api_key', 'XXX'),
    jenkins_credentials_id   => hiera('jenkins_credentials_id', 'XXX'),
    rackspace_username       => hiera('nodepool_rackspace_username', 'username'),
    rackspace_password       => hiera('nodepool_rackspace_password', 'XXX'),
    rackspace_project        => hiera('nodepool_rackspace_project', 'project'),
    hpcloud_username         => hiera('nodepool_hpcloud_username', 'username'),
    hpcloud_password         => hiera('nodepool_hpcloud_password', 'XXX'),
    hpcloud_project          => hiera('nodepool_hpcloud_project', 'project'),
    tripleo_username         => hiera('nodepool_tripleo_username', 'username'),
    tripleo_password         => hiera('nodepool_tripleo_password', 'XXX'),
    tripleo_project          => hiera('nodepool_tripleo_project', 'project'),
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'zuul.openswitch.net' {
  class { 'openstack_project::zuul_prod':
    project_config_repo            => 'https://git.openswitch.net/infra/project-config',
    gerrit_server                  => 'review.openswitch.net',
    gerrit_user                    => 'zuul',
    gerrit_ssh_host_key            => hiera('gerrit_dev_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key           => hiera('zuul_ssh_private_key_contents', 'XXX'),
    #url_pattern                    => 'http://logs.openstack.org/{build.parameters[LOG_PATH]}',
    #swift_authurl                  => 'https://identity.api.rackspacecloud.com/v2.0/',
    #swift_user                     => 'infra-files-rw',
    #swift_key                      => hiera('infra_files_rw_password', 'XXX'),
    #swift_tenant_name              => hiera('infra_files_tenant_name', 'tenantname'),
    #swift_region_name              => 'DFW',
    #swift_default_container        => 'infra-files',
    #swift_default_logserver_prefix => 'http://logs.openstack.org/',
    #swift_default_expiry           => 14400,
    zuul_url                       => 'http://zuul.openswitch.net',
    sysadmins                      => hiera('sysadmins', []),
    #statsd_host                    => 'graphite.openstack.org',
    gearman_workers                => [ # Required to open the ports to listen for them
#      'nodepool.openstack.org',
#      'jenkins.openswitch.net',
#      'jenkins.openswitch.net', '15.126.131.77',
       'jenkins.openswitch.net', '52.11.169.151',
#      'jenkins-dev.openstack.org',
       'zm01.openswitch.net', '52.33.196.156',
#       'zm01.openswitch.net', '15.126.131.252',
#      'zm02.openstack.org',
    ],
  }
}


# Node-OS: precise
# Node-OS: trusty
node /^zm\d+\.openswitch\.net$/ {
  class { 'openstack_project::zuul_merger':
    gearman_server       => 'zuul.openswitch.net',
    gerrit_server        => 'review.openswitch.net',
    gerrit_user          => 'zuul',
    gerrit_ssh_host_key  => hiera('gerrit_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_ssh_private_key_contents', 'XXX'),
    sysadmins            => hiera('sysadmins', []),
  }
}

# Node-OS: precise
# Node-OS: trusty
node 'zuul-dev.openswitch.net' {
  class { 'openstack_project::zuul_dev':
    project_config_repo  => 'https://git.openswitch.net/infra/project-config',
    gerrit_server        => 'review-dev.openswitch.net',
    gerrit_user          => 'zuul',
    gerrit_ssh_host_key  => hiera('gerrit_dev_ssh_rsa_pubkey_contents', 'XXX'),
    zuul_ssh_private_key => hiera('zuul_dev_ssh_private_key_contents', 'XXX'),
    #url_pattern          => 'http://logs.openstack.org/{build.parameters[LOG_PATH]}',
    zuul_url             => 'http://zuul-dev.openswitch.net/p',
    sysadmins            => hiera('sysadmins', []),
    statsd_host          => 'graphite.openstack.org',
    gearman_workers      => [
      'jenkins-dev.openswitch.net','52.37.155.213',
      'zm01-dev.openswitch.net', '52.38.221.85',
    ],
  }
}

# Node-OS: centos6
node 'pbx.openstack.org' {
  class { 'openstack_project::pbx':
    sysadmins     => hiera('sysadmins', []),
    sip_providers => [
      {
        provider => 'voipms',
        hostname => 'dallas.voip.ms',
        username => hiera('voipms_username', 'username'),
        password => hiera('voipms_password', 'XXX'),
        outgoing => false,
      },
    ],
  }
}

# Node-OS: precise
# A backup machine.  Don't run cron or puppet agent on it.
node /^ci-backup-.*\.openstack\.org$/ {
  include openstack_project::backup_server
}

node /^openswitch-slave-.*\.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave':
    ssh_key   => $openstack_project::jenkins_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_password','XXX'),
  }
}

node /^slave-runner-.*.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::runner_slave':
    aws_credentials_content => hiera('slave_runner_aws_credentials', 'XXX'),
    aws_dynamic_key         => hiera('aws_dynamic_slave_key', 'XXX'),
    ssh_key        => $openstack_project::jenkins_ssh_key,
    sysadmins      => hiera('sysadmins', []),
  }
}

node /^openswitch-slave-.*\-dev.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave':
    ssh_key   => $openstack_project::jenkins_dev_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_dev_password','XXX'),
  }
}

node /^slave-jk-.*\.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave':
    ssh_key   => $openstack_project::jenkins_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_password','XXX'),
  }
}

# vsi slave with certain sudo cmd
node /^slave-vsi-.*\.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave_vsi':
    ssh_key   => $openstack_project::jenkins_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_password','XXX'),
  }
}

node /^slave-jk-.*\-dev.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave':
    ssh_key   => $openstack_project::jenkins_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_dev_password','XXX'),
  }
}

# vsi slave with certain sudo cmd
node /^slave-vsi-.*\-dev.openswitch\.net$/ {
  include openstack_project
  class { 'openstack_project::slave_vsi':
    ssh_key   => $openstack_project::jenkins_dev_ssh_key,
    sysadmins               => hiera('sysadmins', []),
    token     => hiera('jenkins_jobs_dev_password','XXX'),
  }
}

# Node-OS: precise
node 'proposal.slave.openstack.org' {
  include openstack_project
  class { 'openstack_project::proposal_slave':
    transifex_username       => 'openstackjenkins',
    transifex_password       => hiera('transifex_password', 'XXX'),
    jenkins_ssh_public_key   => $openstack_project::jenkins_ssh_key,
    proposal_ssh_public_key  => hiera('proposal_ssh_public_key_contents', 'XXX'),
    proposal_ssh_private_key => hiera('proposal_ssh_private_key_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'pypi.slave.openstack.org' {
  include openstack_project
  class { 'openstack_project::pypi_slave':
    pypi_username          => 'openstackci',
    pypi_password          => hiera('pypi_password', 'XXX'),
    jenkins_ssh_public_key => $openstack_project::jenkins_ssh_key,
    jenkinsci_username     => hiera('jenkins_ci_org_user', 'username'),
    jenkinsci_password     => hiera('jenkins_ci_org_password', 'XXX'),
    mavencentral_username  => hiera('mavencentral_org_user', 'username'),
    mavencentral_password  => hiera('mavencentral_org_password', 'XXX'),
    puppet_forge_username  => hiera('puppet_forge_username', 'username'),
    puppet_forge_password  => hiera('puppet_forge_password', 'XXX'),
  }
}

# Node-OS: precise
node 'openstackid.org' {
  class { 'openstack_project::openstackid_prod':
    sysadmins               => hiera('sysadmins', []),
    site_admin_password     => hiera('openstackid_site_admin_password', 'XXX'),
    id_mysql_host           => hiera('openstackid_id_mysql_host', 'localhost'),
    id_mysql_password       => hiera('openstackid_id_mysql_password', 'XXX'),
    id_mysql_user           => hiera('openstackid_id_mysql_user', 'username'),
    id_db_name              => hiera('openstackid_id_db_name', 'XXX'),
    ss_mysql_host           => hiera('openstackid_ss_mysql_host', 'localhost'),
    ss_mysql_password       => hiera('openstackid_ss_mysql_password', 'XXX'),
    ss_mysql_user           => hiera('openstackid_ss_mysql_user', 'username'),
    ss_db_name              => hiera('openstackid_ss_db_name', 'username'),
    redis_password          => hiera('openstackid_redis_password', 'XXX'),
    ssl_cert_file_contents  => hiera('openstackid_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('openstackid_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('openstackid_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: precise
node 'openstackid-dev.openstack.org' {
  class { 'openstack_project::openstackid_dev':
    sysadmins               => hiera('sysadmins', []),
    site_admin_password     => hiera('openstackid_dev_site_admin_password', 'XXX'),
    id_mysql_host           => hiera('openstackid_dev_id_mysql_host', 'localhost'),
    id_mysql_password       => hiera('openstackid_dev_id_mysql_password', 'XXX'),
    id_mysql_user           => hiera('openstackid_dev_id_mysql_user', 'username'),
    ss_mysql_host           => hiera('openstackid_dev_ss_mysql_host', 'localhost'),
    ss_mysql_password       => hiera('openstackid_dev_ss_mysql_password', 'XXX'),
    ss_mysql_user           => hiera('openstackid_dev_ss_mysql_user', 'username'),
    ss_db_name              => hiera('openstackid_dev_ss_db_name', 'username'),
    redis_password          => hiera('openstackid_dev_redis_password', 'XXX'),
    ssl_cert_file_contents  => hiera('openstackid_dev_ssl_cert_file_contents', 'XXX'),
    ssl_key_file_contents   => hiera('openstackid_dev_ssl_key_file_contents', 'XXX'),
    ssl_chain_file_contents => hiera('openstackid_dev_ssl_chain_file_contents', 'XXX'),
  }
}

# Node-OS: centos6
# Node-OS: precise
# Node-OS: trusty
# This is not meant to be an actual node that connects to the master.
# This is a dummy node definition to trigger a test of the code path used by
# nodepool's prepare_node scripts in the apply tests
node 'single-use-slave' {
  class { 'openstack_project::single_use_slave':
    # Test non-default values from prepare_node_bare.sh
    sudo => true,
    thin => false,
  }
}

# Node-OS: trusty
node 'kdc01.openstack.org' {
  class { 'openstack_project::kdc':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: trusty
node 'kdc02.openstack.org' {
  class { 'openstack_project::kdc':
    sysadmins => hiera('sysadmins', []),
    slave     => true,
  }
}

# Node-OS: trusty
node /^afsdb.*\.openstack\.org$/ {
  class { 'openstack_project::afsdb':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: trusty
node /^afs.*\..*\.openstack\.org$/ {
  class { 'openstack_project::afsfs':
    sysadmins => hiera('sysadmins', []),
  }
}

# Node-OS: precise
node 'ask.openstack.org' {
  class { 'openstack_project::ask':
    sysadmins                    => hiera('sysadmins', []),
    db_user                      => hiera('ask_db_user', 'ask'),
    db_password                  => hiera('ask_db_password', 'XXX'),
    redis_password               => hiera('ask_redis_password', 'XXX'),
    site_ssl_cert_file_contents  => hiera('ask_site_ssl_cert_file_contents', undef),
    site_ssl_key_file_contents   => hiera('ask_site_ssl_key_file_contents', undef),
    site_ssl_chain_file_contents => hiera('ask_site_ssl_chain_file_contents', undef),
  }
}

# vim:sw=2:ts=2:expandtab:textwidth=79
