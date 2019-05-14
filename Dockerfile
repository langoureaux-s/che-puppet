FROM registry.centos.org/che-stacks/centos-stack-base:latest

MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>

ARG http_proxy
ARG https_proxy

ENV PUPPET_VERSION=5.3.7 \
    LANG=C.UTF-8 \
    PATH=$PATH:/opt/puppetlabs/puppet/bin

USER root
    
# Install ruby and require for beaker and puppet
RUN \
    rpm -Uvh https://yum.puppet.com/puppet5/puppet5-release-el-7.noarch.rpm &&\
    yum install -y make gcc-c++ libxml2 libxml2-devel libxslt-devel zlib-devel pdk git puppet-agent-${PUPPET_VERSION} &&\
    yum clean all


# Install ruby lib
RUN /opt/puppetlabs/puppet/bin/gem install rspec
RUN /opt/puppetlabs/puppet/bin/gem install rspec-puppet
RUN /opt/puppetlabs/puppet/bin/gem install puppetlabs_spec_helper
RUN /opt/puppetlabs/puppet/bin/gem install puppet-lint
RUN /opt/puppetlabs/puppet/bin/gem install r10k

# Install beaker
RUN /opt/puppetlabs/puppet/bin/gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2
RUN /opt/puppetlabs/puppet/bin/gem install beaker -v 4.0.0
RUN /opt/puppetlabs/puppet/bin/gem install beaker-puppet -v 1.1.0
RUN /opt/puppetlabs/puppet/bin/gem install beaker-puppet_install_helper -v 0.9.7
RUN /opt/puppetlabs/puppet/bin/gem install beaker-pe -v 2.0.6
RUN /opt/puppetlabs/puppet/bin/gem install beaker-module_install_helper -v 0.1.7
RUN /opt/puppetlabs/puppet/bin/gem install beaker-task_helper -v 1.7.2
RUN /opt/puppetlabs/puppet/bin/gem install beaker-rspec -v 6.2.4
RUN /opt/puppetlabs/puppet/bin/gem install beaker-docker -v 0.5.1
RUN /opt/puppetlabs/puppet/bin/gem install beaker-hiera -v 0.1.1

# Install Bolt
RUN yum install -y puppet-bolt-1.8.1 &&\
    yum clean all

USER user

EXPOSE 8080


