#!/usr/bin/python3
import argparse
import os
import sys

import renames  # local

p = argparse.ArgumentParser(prog="genrenames-py",
                            description="Utility to generate a renames.txt file.", epilog="""(c) Tomodachi94 2022, MIT License.
A copy of the license should have been distributed with your copy of the software. If not, see https://mit-license.org .

For more help, see `man genrenames`.
                            """)

p.add_argument("--path", "-p", metavar="PATH", help="The path to search.")
p.add_argument("--output-file", "-o", metavar="PATH.txt", help="The file to dump output to. If blank, the program will dump to stdout.")
p.add_argument("--list-all", "-a", action="store_true", help="Adds all files in a directory to renames.txt.")

if __name__ == "__main__":
    args = p.parse_args(args=None if sys.argv[1:] else ['--help']) # Hacky one-liner to display help by default

    target = args.path

    if args.list_all:
        out = renames.get_all_as_renames(target)
        renames_file = os.path.join(target, "renames.txt")
        if not out:
            print("No files were present in that directory. You should be fine to proceed with uploading.")
        else:
            if not args.output_file:
                print(out)
            else:
                f = open(renames_file)
                f.write(out)
                f.close()
    else:
        out = renames.get_renames(target)
        renames_file = os.path.join(target, "renames.txt")
        if not out:
            print("No matching files to return. You should be fine to proceed with uploading.")
            sys.exit(2)
        else:
            if not args.output_file:
                print(out)
                sys.exit(0)
            else:
                f = open(renames_file)
                f.write(out)
                f.close()
                sys.exit(0)
