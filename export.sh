#!/bin/bash

# export.sh
# Export the Java cacerts truststore certificates.

JAVA_KS=/opt/jdk1.7.0_80/jre/lib/security/cacerts
JAVA_PASS=changeit
TMP_CERTS=tmpcerts

echo -e "deleting ${TMP_CERTS}\n----------------------------------------"
rm -rf $TMP_CERTS
mkdir -p $TMP_CERTS

echo -e "\nexporting to ${TMP_CERTS}\n----------------------------------------"

COUNT=$((0))
for ALIAS in $(keytool -keystore $JAVA_KS -storepass $JAVA_PASS -list | grep trustedCertEntry | cut -d"," -f1); do
    COUNT=$(($COUNT + 1))
    echo -n "$COUNT: ${ALIAS}: "
    keytool -exportcert -alias $ALIAS -keystore $JAVA_KS -storepass $JAVA_PASS -file ${TMP_CERTS}/${ALIAS}.cer
done
echo -e "----------------------------------------\nexported $COUNT certificates"
echo -e "----------------------------------------\ndone\n----------------------------------------"

# end
