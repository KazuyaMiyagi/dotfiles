export DOCKER_BUILDKIT=1
export LESSCHARSET=utf-8
export JAVA_HOME=$(/usr/libexec/java_home)
export TF_CLI_ARGS_plan="--parallelism=50"
export TF_CLI_ARGS_apply="--parallelism=50"
export TF_CLI_ARGS_refresh="--parallelism=50"