@_make_alias("lspath")
def _lspath(*args, **kwargs):
    import os
    for directory in $PATH:
        for file in os.listdir(directory):
            print(f"{directory}/{file}")

@_make_alias("lsgccdefines")
def _lsgccdefines(*args, **kwargs):
    gcc -E -dM - < /dev/null

# vi: sw=4 sts=4 ts=4 et cc=80 ft=python
