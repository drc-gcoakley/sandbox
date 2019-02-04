
command_not_found_handle() {
  # Do not run within a pipe.
  if [ -t 1 ]; then
    if [[ $PWD =~ $ECA ]]; then
      if which npx > /dev/null; then
        echo "$SHELL: did not find $1. Trying with npx..." >&2
        if ! [[ $1 =~ @ ]]; then
          npx --no-install "$@"
        else
          npx "$@"
        fi
      fi
      return $?
    fi
  fi
  echo "$SHELL: command not found: $1" >&2
  return 127 # Indicate not found.
}
