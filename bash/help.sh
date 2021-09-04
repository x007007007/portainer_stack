function help_record_logger() {
    echo $@
}

function help_output_gen_password_hash() {
    docker run -ti --rm httpd:2.4.48-buster htpasswd -Bnb "${1}" "${2}"
}

function help_stop_export_variable() {
    help_record_logger "debug" "stop export variable"
    set +o allexport
}
function help_start_export_variable() {
    set -o allexport
    trap help_stop_export_variable INT QUIT TERM ERR
}
