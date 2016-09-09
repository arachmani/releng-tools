#!/bin/sh -e

# The name, version and source of the package:
name="ovirt-engine-wildfly"
version="10.1.0"
qualifier="Final"
src="wildfly-${version}.${qualifier}.zip"
url="http://download.jboss.org/wildfly/${version}.${qualifier}/${src}"

# Download the source:
if [ ! -f "${src}" ]
then
    wget -O "${src}" "${url}"
fi

# Generate the spec from the template:
sed \
    -e "s/@VERSION@/${version}/g" \
    -e "s/@QUALIFIER@/${qualifier}/g" \
    -e "s/@SRC@/${src}/g" \
    < "${name}.spec.in" \
    > "${name}.spec"

# Build the source and binary packages:
rpmbuild \
    -bs \
    --define="_sourcedir ${PWD}" \
    --define="_srcrpmdir ${PWD}" \
    --define="_rpmdir ${PWD}" \
    "${name}.spec"
