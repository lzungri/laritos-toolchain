#!/usr/bin/env python3
import os
import sys
import argparse
import subprocess


def main(args):
    script_dir = os.path.dirname(os.path.realpath(__file__))

    env = os.environ.copy()
    env["ARCH"] = args.arch
    env["SUBARCH"] = args.subarch
    env["CROSS_COMPILE"] = args.crossc
    env["LARITOS_TOOLCHAIN"] = os.path.join(script_dir, "..")

    if args.install:
        env["INSTALL_DIR"] = args.install

    makeargs = []
    if args.verbose:
        makeargs.append("V=1")
    if args.clean:
        makeargs.append("clean")
    if args.install:
        makeargs.append("install")
    if args.printdatabase:
        makeargs.append("-p")

    for app in args.apps:
        if not os.path.isdir(app) or not os.path.isfile(os.path.join(app, "Makefile")):
            print("Ignoring '{}', not a valid laritOS application".format(app))
            continue
        print("Building '{}'".format(app))
        makecmd = ["make", "-f", os.path.join(script_dir, "main.mk"),
                   "-C", os.path.realpath(app)] + makeargs
        subprocess.check_call(makecmd, env=env)


def parse_args(argv):
    parser = argparse.ArgumentParser(description="laritOS application builder",
                                     formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("apps", metavar="app", nargs="+",
                        help="Path to the application to build")
    group = parser.add_mutually_exclusive_group()
    group.add_argument("-i", "--install", metavar="path",
                       help="Install object files in the given system image root path")
    group.add_argument("-c", "--clean", default=False, action="store_true",
                       help="Remove all objects rather than building the app/s")
    parser.add_argument("--arch", default="arm",
                        help="Target architecture")
    parser.add_argument("--subarch", default="armv7-a",
                        help="Target sub-architecture (if any)")
    parser.add_argument("-p", "--printdatabase", default=False, action="store_true",
                        help="Print the data base (rules and variable values) that \
                        results from reading  the  makefiles")
    parser.add_argument("--crossc", default="arm-none-eabi-",
                        help="Cross compiler")
    parser.add_argument("-v", "--verbose", default=False, action="store_true",
                        help="Increase logging")
    return parser.parse_args(argv)


if __name__ == "__main__":
    try:
        args = parse_args(sys.argv[1:])
        main(args)
        sys.exit(0)
    except Exception as e:
        print("Error: {}".format(str(e)))
        sys.exit(1)
