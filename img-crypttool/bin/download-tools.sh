#!/bin/sh
set -e

# Download oc client and oc-mirror
VERSION="stable-4.20"
BASE="https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/$VERSION"

for file in openshift-client-linux.tar.gz sha256sum.txt
do
  curl -f -OL $BASE/$file
done

# Verify downloads
sha256sum --check --ignore-missing sha256sum.txt

# Extract and move to /usr/local/bin/
tar zxf openshift-client-linux.tar.gz && mv oc /usr/local/bin/

# Download crypttool
VERSION_WITHOUT_V="1.0.4"
BASE="https://github.com/belastingdienst/opr-paas-crypttool/releases/download/v$VERSION_WITHOUT_V"

for file in crypttool_Linux_x86_64.tar.gz opr-paas-crypttool_${VERSION_WITHOUT_V}_checksums.txt
do
  curl -f -OL $BASE/$file
done

# Verify downloads
sha256sum --check --ignore-missing opr-paas-crypttool_${VERSION_WITHOUT_V}_checksums.txt

# Extract and move to /usr/local/bin/
tar zxf crypttool_Linux_x86_64.tar.gz && mv crypttool /usr/local/bin/
