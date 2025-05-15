#!/bin/bash
# Author @tenapato
# Usage: ./curl-cli.sh <command> [options]
# Commands: list, help, or script name

show_help() {
    echo "Usage: ./curl-cli.sh <command> [options]"
    echo ""
    echo "Commands:"
    echo "  list [-t|--tree] [-f|--flat]    List available scripts"
    echo "  help                            Show this help message"
    echo "  <script-path> [key=value]...    Run a specific script"
    echo ""
    echo "Options for list:"
    echo "  -t, --tree    Show scripts in tree structure"
    echo "  -f, --flat    Show scripts in flat list (default)"
    echo ""
    echo "Examples:"
    echo "  ./curl-cli.sh list                    Show available scripts"
    echo "  ./curl-cli.sh list -t                 Show scripts in tree structure"
    echo "  ./curl-cli.sh rebalance id=123        Run rebalance script"
    echo "  ./curl-cli.sh subdir/script id=123    Run script from subdirectory"
}

list_scripts_flat() {
    echo "Available scripts:"
    find ./scripts -name "*.sh" | while read -r script; do
        relative_path=${script#./scripts/}
        relative_path=${relative_path%.sh}
        echo "  - $relative_path"
    done
}

list_scripts_tree() {
    echo "Scripts Directory Structure:"
    local prefix="  "
    
    # First list files in root of scripts directory
    for script in ./scripts/*.sh; do
        if [ -f "$script" ]; then
            echo "${prefix}|- $(basename "$script" .sh)"
        fi
    done

    # Then list subdirectories and their contents
    for dir in ./scripts/*/; do
        if [ -d "$dir" ]; then
            echo "${prefix}[+] $(basename "$dir")"
            for script in "$dir"*.sh; do
                if [ -f "$script" ]; then
                    echo "${prefix}${prefix}|- $(basename "$script" .sh)"
                fi
            done
        fi
    done
}

# Command handling
case "$1" in
    "help")
        show_help
        exit 0
        ;;
    "list")
        case "$2" in
            "-t"|"--tree")
                list_scripts_tree
                ;;
            "-f"|"--flat"|"")
                list_scripts_flat
                ;;
            *)
                echo "Error: Invalid flag for list command"
                echo "Use './curl-cli.sh help' for usage information"
                exit 1
                ;;
        esac
        exit 0
        ;;
    "")
        echo "Error: No command specified"
        echo "Use './curl-cli.sh help' for usage information"
        exit 1
        ;;
    *)
        SCRIPT="$1"
        shift

        # Remove .sh extension if provided
        SCRIPT="${SCRIPT%.sh}"
        
        # Construct the full path
        SCRIPT_PATH="./scripts/$SCRIPT.sh"

        if [ ! -f "$SCRIPT_PATH" ]; then
            echo "Error: Script '$SCRIPT' not found"
            echo "Use './curl-cli.sh list' to see available scripts"
            exit 1
        fi

        bash "$SCRIPT_PATH" "$@"
        ;;
esac