#!/usr/bin/env python3
"""
https://github.com/drduh/config/blob/master/scripts/rename.py

Random rename of files at path.
"""

import os
import random
import string
import sys

CHARSET = string.ascii_lowercase


def confirmation(path):
    """Ask for confirmation."""
    if input(f"Rename '{path}'? ").lower().startswith("y"):
        return True
    return False


def rename(path, length=8):
    """Find and rename files in path, normalize extensions.

    Args:
        path: string, directory with files to rename
        length: int, length of renamed filename.
    """
    target = os.listdir(path)
    print(f"Renaming {len(target)} files ...")

    for item in target:
        ext = os.path.splitext(item)[1].lower()
        if ext == ".jpeg":
            ext = ".jpg"
        rand = "".join(random.sample(CHARSET, length)) + ext

        if not os.path.isfile(path + rand):
            os.rename(os.path.join(path, item),
                      os.path.join(path, rand))
            print(f"Renamed {item} to {rand}")
        else:
            print(f"{path} {rand} already exists!")


def main(argv):
    """Main function."""
    if len(argv) < 2:
        argv.append(".")

    path = os.path.abspath(argv[1])
    if not os.path.isdir(path):
        print(f"Path '{path}' does not exist!")
        return

    length = 8
    if len(sys.argv) > 2:
        length = argv[2]

    if int(length) > len(CHARSET):
        print(f"Length cannot exceed {len(CHARSET)}!")
        return

    if confirmation(path):
        rename(path, int(length))


if __name__ == "__main__":
    main(sys.argv)
