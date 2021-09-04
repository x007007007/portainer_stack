
function help_record_logger() {
    echo $@
}

function help_output_gen_username_password_hash() {
    docker run -ti --rm httpd:2.4.48-buster htpasswd -Bnb "${1}" "${2}"
}

function help_stop_export_variable() {
    help_record_logger "debug" "stop export variable"
    __help_compare_export=`export | grep -o "\w*=" |cut -d'=' -f1|sort`
    set +o allexport
}
function help_start_export_variable() {
    set -o allexport
    trap help_stop_export_variable INT QUIT TERM ERR
}

function help_docker_network_create_overlay() {
    local network_name=&1
    if [[ -z `docker network ls |grep "\W${network_name}\W"` ]] ;then
        docker network create --driver=overlay ${network_name} ||true
    fi
}