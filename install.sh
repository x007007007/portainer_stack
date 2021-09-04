#!/bin/bash
. bash/help.sh

read -p "traefik USERNAME:" username
read -sp "traefik PASSWORD:" password
read -p "Let's Encrypt Email:" email
read -p "DOMAIN_ROOT": domain

##----->
hashed_auth=`help_output_gen_password_hash "${username}" "${password}"`
help_start_export_variable;

HASHED_PASSWORD=${hashed_auth#*:}
USERNAME=${hashed_auth%%:*}
EMAIL=$email
TRAEFIK_DOMAIN=traefik.${domain}
AUTHELIA_DOMAIN=authelia.${domain}

if [[ -e .env ]]; then . .env ; fi

help_end_export_variable;
##<-----

help_docker_network_create_overlay traefik-public
docker stack deploy traefik -c traefik.yml




