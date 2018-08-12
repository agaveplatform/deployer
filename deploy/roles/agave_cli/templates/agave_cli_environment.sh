#!/usr/bin/env bash

export PATH=$PATH:{{agave_cli_deployment_directory}}/bin
export AGAVE_JSON_PARSER={{agave_cli_json_parser}}
export AGAVE_TENANTS_API_BASEURL=https://{{agave_public_domain_or_ip}}/tenants
