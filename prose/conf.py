#!/usr/bin/env python3
# -*- coding: utf-8 -*-
#
# nixpkgs-cookbook documentation build configuration file, created by
# sphinx-quickstart on Sun Apr 24 14:57:40 2016.
#
# This file is execfile()d with the current directory set to its
# containing dir.
#
# Note that not all possible configuration values are present in this
# autogenerated file.
#
# All configuration values have a default; values that are commented out
# serve to show the default.

import sys
import os
from datetime import date

# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
# sys.path.insert(0, os.path.abspath('.'))

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
# needs_sphinx = '1.0'

import os
import sys

extensions = [
    "myst_parser",
    "sphinx.ext.intersphinx",
    "sphinx.ext.mathjax",
    "sphinx.ext.todo",
    "sphinx_copybutton",
]

myst_enable_extensions = [
    "colon_fence",
    "linkify",
    "dollarmath"
]

myst_heading_anchors = 3

copybutton_prompt_text = r"# |\$ "
copybutton_prompt_is_regexp = True

templates_path = ["_templates"]

source_suffix = ['.rst', '.md']

master_doc = "index"

project = "tmath"
author = "suhr"

language = 'ru'

# List of patterns, relative to source directory, that match files and
# directories to ignore when looking for source files.
# This patterns also effect to html_static_path and html_extra_path
exclude_patterns = []

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = "sphinx"


# -- Options for HTML output ----------------------------------------------

html_theme = "sphinx_book_theme"

# Custom sidebar templates, maps document names to template names.
html_sidebars = {
    "**": [
        "search-field.html",
        "sbt-sidebar-nav.html",
    ],
}

linkcheck_ignore = [
    # It's a SPA
    r"https://app.terraform.io",
    # It's dynamic
    r"https://matrix.to",
]
