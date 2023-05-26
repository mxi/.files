# NOTE(2023-05-26) I have since become a better command liner and don't have
# a use for this anymore.
#
# A tiny `rm' replacement without the bloat of trash-cli's Python for a 
# *relatively* trivial task.

function () {
  
}

function _trash_put() {
  [ $# -eq 0 ]                          \
    && print-error "No files to trash!" \
    && return 1

  local items=("$@")
  while (( 0 < ${#items} )); do

    # cost := how much space is required to store it in trash (0 if on the same fs.)
    _item[cost]=0
    # path := full path to the file.
    _item[path]=$(realpath -- "$item")
    # type in { "directory", "regular file", "symbolic link" }.
    _item[type]=$(stat --printf="%F" -- "$item")
    # base := mountpoint of the filesystem containing the item.
    _item[base]=$(df --output=target "$item" | tail -n 1)
    # branch := path to the file relative to the mountpoint.
    _item[branch]=${_trash_item_path#${_trash_item_base}}
    # fs := the filesystem ID used to check whether moving will cost us.
    _item[fs]=$(stat -f --printf="%i" -- "$item")

    print-debug ${(@kv)_item}
                
    # if the path is on a different filesystem, compute the size cost
    if [ "$_trash_fs" != "$_trash_item_fs" ]; then
      _item[cost]=$(du -s "$item" | cut -f1)
      _item[size]=$(du -h "$item" | cut -f1)
    fi

    # check against size constraints
    local size_constraint=$(df --output=avail "$_trash_dir" | tail -n 1)
    if [ $size_constraint -le $_item[cost] ]; then
      print-warning "Cannot trash $item because it's too large ($_item[size])!"
      continue
    fi
    
    unset _item
  done
}

function trash-put() {
  local program_name="trash-put"

  local _trash_dir="$XDG_CACHE_HOME/.trash"
  if ! mkdir -p "$_trash_dir"; then
    print-error "Failed to create directory, $_trash_dir"
    return 1
  fi
  local _trash_fs=$(stat -f --printf="%i" "$_trash_dir")

  _trash_put "$@"
}

function trash-recover() {

}

function dir-bfs() {
  local items=("$@")
  while (( 0 < ${#items} )); do
    local item="$items[1]"
    shift items
    if [ -d "$item" ]; then
      items+=($(ls "$item"))
      continue
    fi
    echo "item: $item"
  done
}

# vi: sw=2 sts=2 ts=2 et cc=80 ft=zsh
