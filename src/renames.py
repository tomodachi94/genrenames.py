import os
import re


def _strip_full_path(target: str):
    """
    Strips any folders present in a path, leaving only the filename.
    """
    target = target.split("/")
    out = target[-1]
    return out


def _has_underscore(target: str):
    """
    Checks if a filename contains an underscore.
    """

    target = _strip_full_path(target)
    match_pattern = "_"
    out = re.search(match_pattern, target)

    if out:
        out = True
    else:
        out = False
    return out


def get_renames(folder):
    """
    Returns a newline-delimited string of files containing underscores.
    """

    matches = []
    files = os.listdir(folder)
    for item in files:
        if _has_underscore(item):
            matches.append(item)
    if len(matches) == 0:  # makes sure that there is something to give back
        return False
    else:
        out = "=\n".join(matches)
        out = out + "="  # fixes last line
        return out


def get_all_as_renames(folder):
    """
    Returns a full list of items in the directory in `renames.txt` format.
    """

    out = []
    files = os.listdir(folder)
    for item in files:
        out.append(item)

    if len(out) == 0:
        return False
    else:
        out = "=\n".join(out)
        out = out + "="  # fixes last line
        return out
