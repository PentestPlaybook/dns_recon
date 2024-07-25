#!/bin/bash

check_dns_status() {
    local ip=$1

    output=$(dig @$ip google.com 2>&1)

    if [[ $output == *"connection refused"* ]]; then
        echo "$ip is neither a DNS server nor a DNS resolver."
    elif [[ $output == *"timed out"* ]]; then
        echo "$ip is a DNS resolver."
    elif [[ $output == *"Got answer"* ]]; then
        echo "$ip is a DNS server."
    else
        echo "Unable to determine the status of $ip."
    fi
}

if [[ $# -eq 0 ]]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

check_dns_status $1
