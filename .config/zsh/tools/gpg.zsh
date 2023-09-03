silent-pushd() >&/dev/null {
  pushd "$@"
}

silent-popd() >&/dev/null {
  popd
}

gpg-export() {
  local program="$0"
  local usage="usage: $program ARCHIVE-NAME [SECRET-KEY...]"

  # arguments
  local name=$1
  [ -z "$name" ]                            \
    && print-error "$usage"                 \
    && print-error "Archive name required!" \
    && return 1

  local archive="${name%.tgz}.tgz"
  [ -e "$archive" ]                                         \
    && print-error "File with archive name already exists." \
    && return 1

  shift && local secretkeys="$@"

  # tmp and tar
  local tmpdir=$(mktemp -d "/tmp/${program}_XXXXXX")
  [ -z "$tmpdir" ]                                         \
    && print-error "Failed to create temporary directory." \
    && return 1

  print-info "Created temporary directory, $tmpdir"

  silent-pushd "$tmpdir"
    print-info "Exporting public keys..."
    gpg --armor --output public-keys.asc \
      --export-options backup --export
    print-info "Exporting secret keys... (may require passphrase!)"
    gpg --armor --output secret-keys.asc \
      --export-options backup --export-secret-keys $secretkeys
    print-info "Exporting secret subkeys... (may require passphrase!)"
    gpg --armor --output secret-subkeys.asc \
      --export-options backup --export-secret-subkeys $secretkeys
    print-info "Exporting ownertrust..."
    gpg --export-ownertrust > owner-trust.txt
    tar -czf archive.tgz *
  silent-popd

  local tmp_archive="$tmpdir/archive.tgz"

  if mv "$tmp_archive" "$archive"; then
    # successfully move to destination
    print-info "Done. Removing temporary directory, $tmpdir"
    \rm -r "$tmpdir"
  else
    # failed to move to destination
    print-error "Failed to move $tmp_archive into destination $archive!"
    print-error "If root is required, move $tmp_archive manually!"
  fi
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
