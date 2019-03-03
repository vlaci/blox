#!/usr/bin/env python3
"""Generates markdown document from JSON option description exported from nix"""

import collections
import collections.abc
import json
import os
import sys
import textwrap


Option = collections.namedtuple(
    "Option",
    ["title", "description", "example", "type", "default", "declared", "valid_in"],
)

HEADER = """\
# Name

blox - Supported configuration options

# Description

This module defines a couple of customization options and extend some built-in ones too.

# Options

The following section lists all custom options available in this configuration.
"""

SECTION = """\
## Options valid in {} {} configurations:
"""

FOOTER = """\
# See Also

[`configuration.nix(5)`](https://nixos.org/nixos/manual/options.html),
[`home-configuration.nix(5)`](https://rycee.gitlab.io/home-manager/options.html)"""


def write_md(input_file):
    with open(input_file) as f:
        doc = json.load(f)

    print(HEADER)

    by_title = collections.defaultdict(list)
    for opt in doc:
        opt = get_option(opt)
        by_title[opt.title].append(opt)

    by_validity = collections.defaultdict(list)
    for opts in by_title.values():
        opt = merge_opts(opts)
        by_validity[tuple(opt.valid_in)].append(opt)

    for valid_in, opts in sorted(by_validity.items(), reverse=True):
        print(
            SECTION.format(
                "only" if len(
                    valid_in) == 1 else "both", " and ".join(valid_in)
            )
        )
        for opt in opts:
            print(format_md(opt))

    print(FOOTER)


def get_option(chapter):
    title = chapter["name"]
    description = chapter["description"]
    example = chapter.get("example", None)
    # skip useless boolean/int examples
    if example and isinstance(example, str):
        example = example.strip()
        if example.count("\n") > 0:
            example = f"\n*Example:*\n\n```nix\n{example}\n```\n"
        else:
            example = f"\n*Example:* `{example}`\n"
    else:
        example = ""

    type = chapter["type"]

    default = ""
    if "default" in chapter:  # None is a valid value
        default = chapter["default"]
        ldelim = "`"
        rdelim = ldelim
        if isinstance(default, (bool, str)) or default is None:
            # Nix has a JSON like syntax for primitive types
            default = json.dumps(default).replace(r"\n", "\n")
            if "\n" in default:
                # defaultText uses weird formatting
                # nix is a safe bet for syntax highlight for us
                ldelim = "\n```nix\n"
                rdelim = "```\n"
                default = default.strip("\"")
        default = f"\n*Default:* {ldelim}{default}{rdelim}"

    declared = [norm_path(d) for d in chapter["declarations"]]
    valid_in = [chapter["valid_in"]]
    return Option(title, description, example, type, default, declared, valid_in)


def merge_opts(options):
    result = {}
    for name in options[0]._asdict().keys():
        for opt in options:
            candidate = opt._asdict()[name]
            if not isinstance(candidate, str) and isinstance(
                candidate, collections.abc.Sequence
            ):
                result.setdefault(name, []).extend(candidate)
                continue
            if candidate or name not in result:
                result[name] = candidate
            if candidate:
                break
    return Option(**result)


def format_md(option):
    params = option._asdict()
    params["valid_in"] = ", ".join(option.valid_in)
    params["declared"] = "\n".join(
        [f"> **[`<{d}>`](../{d})**  " for d in option.declared]
    )
    return textwrap.dedent(
        """\
    ### {title}

    {description}

    *Type:* `{type}`

    {default}
    {example}
    *Declared by:*

    {declared}

    *Valid in:* {valid_in}
    """
    ).format(**params)


def norm_path(p):
    if not p.endswith(".nix"):
        # Maybe shouldn't put options in default.nix files?
        p += "/default.nix"
    return p.strip("/")


if __name__ == "__main__":
    write_md(sys.argv[1])
