#!/bin/bash
. bash/help.sh

read -p "traefik USERNAME:" USERNAME
read -sp "traefik PASSWORD:" PASSWORD
read -p "Let's Encrypt Email:" EMAIL
read -p "DOMAIN_ROOT": DOMAIN

##----->
help_start_export_variable;

HASHED_PASSWORD=`help_output_gen_password_hash "${USERNAME}" "${PASSWORD}"`
EMAIL=$EMAIL
TRAEFIK_DOMAIN=traefik.${DOMAIN}
AUTHELIA_DOMAIN=authelia.${DOMAIN}

if [[ -e .env ]]; then . .env ; fi

help_end_export_variable;
##<-----

help_docker_network_create_overlay traefik-public
docker stack deploy traefik -c traefik.yml




