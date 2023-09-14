silent_pushd() >&/dev/null {
  pushd "$@"
}

silent_popd() >&/dev/null {
  popd
}

gpg_export() {
  local program="$0"
  local usage="usage: $program ARCHIVE-NAME [SECRET-KEY...]"

  # arguments
  local name=$1
  [ -z "$name" ]                            \
    && print_error "$usage"                 \
    && print_error "Archive name required!" \
    && return 1

  local archive="${name%.tgz}.tgz"
  [ -e "$archive" ]                                         \
    && print_error "File with archive name already exists." \
    && return 1

  shift && local secretkeys="$@"

  # tmp and tar
  local tmpdir=$(mktemp -d "/tmp/${program}_XXXXXX")
  [ -z "$tmpdir" ]                                         \
    && print_error "Failed to create temporary directory." \
    && return 1

  print_info "Created temporary directory, $tmpdir"

  silent_pushd "$tmpdir"
    print_info "Exporting public keys..."
    gpg --armor --output public-keys.asc \
      --export-options backup --export
    print_info "Exporting secret keys... (may require passphrase!)"
    gpg --armor --output secret-keys.asc \
      --export-options backup --export-secret-keys $secretkeys
    print_info "Exporting secret subkeys... (may require passphrase!)"
    gpg --armor --output secret-subkeys.asc \
      --export-options backup --export-secret-subkeys $secretkeys
    print_info "Exporting ownertrust..."
    gpg --export-ownertrust > owner-trust.txt
    tar -czf archive.tgz *
  silent_popd

  local tmp_archive="$tmpdir/archive.tgz"

  if mv "$tmp_archive" "$archive"; then
    # successfully move to destination
    print_info "Done. Removing temporary directory, $tmpdir"
    \rm -r "$tmpdir"
  else
    # failed to move to destination
    print_error "Failed to move $tmp_archive into destination $archive!"
    print_error "If root is required, move $tmp_archive manually!"
  fi
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
