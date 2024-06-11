#!/bin/bash

# Function to display usage
usage() {
    echo "Usage: $0 <command> [<ip1> [<ip2> <ip3> <ip4>]]"
    echo "Commands:"
    echo "  start <ip1> [<ip2> <ip3> <ip4>] - Start the nodes with provided IPs"
    echo "  stop                           - Stop the Docker Compose setup"
    echo "  rm                             - Remove the stopped containers"
    exit 1
}

# Function to start the Docker Compose setup
start() {
    # Check the number of arguments for start
    if [ "$#" -eq 1 ]; then
        # If only one IP address is provided, use it for all 4 nodes
        NODE_IPS="$1,$1,$1,$1"
    elif [ "$#" -eq 4 ]; then
        # If 4 IP addresses are provided, use them
        NODE_IPS="$1,$2,$3,$4"
    else
        # If the number of arguments is not 1 or 4, display usage
        usage
    fi

    # Export the NODE_IPS environment variable
    export NODE_IPS

    rm -rf node*
    # Run the Docker Compose setup
    docker-compose up
}

# Function to stop the Docker Compose setup
stop() {
    docker-compose down
}

# Function to remove the stopped containers
remove_containers() {
    docker-compose rm -f
}

# Check the command provided
if [ "$#" -lt 1 ]; then
    usage
fi

COMMAND=$1
shift

case "$COMMAND" in
    start)
        start "$@"
        ;;
    stop)
        stop
        ;;
    rm)
        remove_containers
        ;;
    *)
        usage
        ;;
esac
