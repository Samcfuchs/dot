#!/bin/bash

. /home/sam/keys.env

DNS_RECORD_ID=4e266f312a7179911648a2af05a4335a
PUBLIC_IP=$(curl -s https://cloudflare.com/cdn-cgi/trace | grep ip= | sed s/ip=//)

echo "API key: $CLOUDFLARE_API_KEY"
echo "Public IP: $PUBLIC_IP"
echo

curl -s "https://api.cloudflare.com/client/v4/user/tokens/verify"  \
--header "Authorization: Bearer ${CLOUDFLARE_API_KEY}" | jq

echo 
echo

curl -s https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$DNS_RECORD_ID \
    -X PUT \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
    -d @- <<EOF |
{
  "comment": "DNS set dynamically on $(date)",
  "content": "$PUBLIC_IP",
  "name": "lan.samcfuchs.com",
  "ttl": 3600,
  "type": "A"
}
EOF
jq

echo
echo "Complete"
