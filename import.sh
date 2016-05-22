#!/bin/bash

# import.sh
# Import all certificates in a directory into a truststore using the filename as the alias.

TMP_CERTS=tmpcerts
LOCAL_KS="./local-ks.jks"
read -sp "${LOCAL_KS} password: " LOCAL_PASS

echo -e "importing from ${TMP_CERTS}\n----------------------------------------"

COUNT=$((0))
for CERT in ${TMP_CERTS}/* ; do
    COUNT=$(($COUNT + 1))
    ALIAS=$(basename $CERT | cut -d"." -f1)
    echo -n "$COUNT: ${CERT} / ${ALIAS}: "
    keytool -importcert -alias $ALIAS -keystore $LOCAL_KS -storepass $LOCAL_PASS -file ${CERT} -noprompt
done
echo -e "----------------------------------------\nimported $COUNT certificates"
echo -e "----------------------------------------\ndone\n----------------------------------------"

# end
