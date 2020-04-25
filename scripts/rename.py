#!/usr/bin/env python3
# https://github.com/drduh/config/blob/master/scripts/rename.py

import os
import random
import string
import sys

def main(argv):
    """Find and rename files in path."""
    path = argv[1]

    for item in os.listdir(path):
        rand = "".join(
            random.sample(
                string.ascii_lowercase, 8)) + \
                os.path.splitext(item)[1]

        print("{} > {}".format(item, rand))
        if not os.path.isfile(path + rand):
            os.rename(os.path.join(path, item),
                      os.path.join(path, rand))
        else:
            print(path + rand, "already exists!")

if __name__ == "__main__":
    main(sys.argv)
