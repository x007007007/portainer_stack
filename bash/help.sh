
function help_record_logger() {
    echo $@
}

function help_output_gen_username_password_hash() {
    docker run -ti --rm httpd:2.4.48-buster htpasswd -Bnb "${1}" "${2}"
}


function help_export_variable_start() {
    if [[ $1 ]]; then
      __help_export_variable_env_config_name=$1
      __help_export_variable_compare_export=`export | grep -o "\w*=" |cut -d'=' -f1|sort`
    else
      unset __help_export_variable_compare_export
      unset __help_export_variable_env_config_name
    fi

    set -o allexport
    trap help_stop_export_variable INT QUIT TERM ERR
}
function help_export_variable_stop() {
    help_record_logger "debug" "stop export variable"
    set +o allexport
    if [[ -n "${__help_export_variable_env_config_name}" ]]; then
      local current_export=`export | grep -o "\w*=" |cut -d'=' -f1|sort`
      sort  <(echo "${__help_export_variable_compare_export}"| tr ' ' '\n') \
            <(echo ${current_export}|tr ' ' '\n')   \
            |uniq -u|xargs -I {} echo {}=\${} |envsubst >.env_${__help_export_variable_env_config_name}
    fi
}

function help_docker_network_overlay_create() {
    local network_name=&1
    if [[ -z `docker network ls |grep "\W${network_name}\W"` ]] ;then
        docker network create --driver=overlay ${network_name} ||true
    fi
}