#!/usr/bin/env python3
# https://github.com/drduh/config/blob/master/scripts/rename.py

import os
import random
import string

def main():
    """Find and rename files in path."""
    path = "/mnt/sshfs/files/"

    for item in os.listdir(path):
        rand = "".join(
            random.sample(
                string.ascii_lowercase, 20)) + \
                os.path.splitext(item)[1]

        print("{} > {}".format(item, rand))
        os.rename(path + item, path + rand)

if __name__ == "__main__":
    main()
