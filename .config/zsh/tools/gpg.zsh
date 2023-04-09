function gpg-export() {
  local program="$0"
  local usage="usage: $program ARCHIVE-NAME [SECRET-KEY...]"

  # arguments
  local name=$1
  [ -z "$name" ]                                      \
    && echo -n >&2 "$usage\nArchive name required.\n" \
    && return 1

  local archive="$name.tgz"
  [ -e "$archive" ]                                                   \
    && echo -n >&2 "$usage\nFile with archive name already exists.\n" \
    && return 1

  shift && local secretkeys="$@"

  # tmp and tar
  local tmpdir=$(mktemp -d "/tmp/${program}_XXXXXX")
  [ -z "$tmpdir" ]                                      \
    && echo >&2 "Failed to create temporary directory." \
    && return 1
  pushd "$tmpdir"
  gpg --armor --output pub.asc --export-options backup --export
  gpg --armor --output sec.asc --export-options backup --export-secret-keys $secretkeys
  gpg --armor --output sub.asc --export-options backup --export-secret-subkeys $secretkeys
  gpg --export-ownertrust > otrust.txt
  tar -czf archive.tgz .
  popd

  if mv "$tmpdir/archive.tgz" "$archive"; then
    # successfully move to destination
    echo >&2 "Done."
    rm -r "$tmpdir"
  else
    # failed to move to destination
    echo >&2 "Failed to move $tmpdir/archive.tgz into destination $archive"
  fi
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
