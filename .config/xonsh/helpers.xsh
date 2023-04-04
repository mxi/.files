def make_alias(name):
    def wrapper(func):
        aliases[name] = func
        return func
    return wrapper

@make_alias("lspath")
def _lspath(*args, **kwargs):
    import os
    for directory in $PATH:
        for file in os.listdir(directory):
            print(f"{directory}/{file}")

# vi: sw=4 sts=4 ts=4 et cc=80 ft=python
