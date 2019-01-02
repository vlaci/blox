#!/usr/bin/env python3
""" Pandoc filter to make generated man pages more idiomatic"""

from pandocfilters import Header, Str, toJSONFilter, walk
import sys


def format_man(key, val, fmt, meta):
    if key == "Link":
        return val[1]
    if key == "Header" and val[0] == 1:
        return Header(*walk(val, caps, fmt, meta))


def caps(key, value, format, meta):
    if key == "Str":
        return Str(value.upper())


if __name__ == "__main__":
    toJSONFilter(format_man)
