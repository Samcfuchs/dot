#!/bin/bash

. ~/keys.env

domain=samcf.com
subnet=lan

public_ip=$( curl -s https://cloudflare.com/cdn-cgi/trace | grep ip= | sed s/ip=// );
echo Public IP: $public_ip

echo CLOUDFLARE_API_KEY: $CLOUDFLARE_API_KEY

set_dns_record() {
    # First argument should be the dns record id of the record to update

    curl -s https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records/$1 \
        -X PUT \
        -H 'Content-Type: application/json' \
        -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
        -d @- <<EOF |
{
  "comment": "DNS set dynamically on $(date)",
  "content": "$public_ip",
  "name": "$subnet.$domain",
  "ttl": 3600,
  "type": "A"
}
EOF
jq

}

zone_id=$(curl -s https://api.cloudflare.com/client/v4/zones \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
| jq -r '.result | map(select(.name == "'"$domain"'"))[0] | .id')

echo Zone ID for $domain: $zone_id

dns_record_ids=$(curl -s https://api.cloudflare.com/client/v4/zones/$zone_id/dns_records \
    -H 'Content-Type: application/json' \
    -H "Authorization: Bearer $CLOUDFLARE_API_KEY" \
| jq -r '.result | map(select(.comment // empty | contains ("DNS set dynamically on"))) | map(.id) | .[]')

for id in $dns_record_ids; do
    set_dns_record $id
done

exit 0

