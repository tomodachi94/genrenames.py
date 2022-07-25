import argparse
import os

import renames  # local

p = argparse.ArgumentParser(prog="genrenames-py",
                            description="Utility to generate a renames.txt file.",
                            epilog="""(c) Tomodachi94 2022, MIT License.
                            A copy of the license should have been distributed with your copy of the software. If not, see https://mit-license.org .

                            For more help, see `man genrenames`.
                            """)

p.add_argument("--path", "-p", metavar="PATH", type=str, help="The path to search.")
p.add_argument("--output-file", "-o", metavar="PATH.txt", type=str, help="The file to dump output to. If blank, the program will dump to stdout.")


args = p.parse_args()

target = args.path

out = renames.get_renames(target)
renames_file = os.path.join(target, "renames.txt")
if not out:
    print("No matching files to return. You should be fine to proceed with uploading.")
else:
    if not args.output_file:
        print(out)
    else:
        f = open(renames_file)
        f.write(out)
        f.close()
