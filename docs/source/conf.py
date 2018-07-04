# -*- coding: utf-8 -*-
#
# CoTIM documentation build configuration file, created by
# sphinx-quickstart on Fri Jun 12 11:01:03 2015.
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
import shlex
import recommonmark
from recommonmark.transform import AutoStructify


# If extensions (or modules to document with autodoc) are in another directory,
# add these directories to sys.path here. If the directory is relative to the
# documentation root, use os.path.abspath to make it absolute, like shown here.
#sys.path.insert(0, os.path.abspath('.'))

# -- General configuration ------------------------------------------------

# If your documentation needs a minimal Sphinx version, state it here.
#needs_sphinx = '1.0'


source_parsers = {
   '.md': 'recommonmark.parser.CommonMarkParser',
}

github_doc_root = 'https://github.com/rtfd/recommonmark/tree/master/doc/'
def setup(app):
    app.add_config_value('recommonmark_config', {
            'url_resolver': lambda url: github_doc_root + url,
            'auto_toc_tree_section': 'Contents',
            }, True)
    app.add_transform(AutoStructify)

# Add any Sphinx extension module names here, as strings. They can be
# extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
# ones.
extensions = []

# Add any paths that contain templates here, relative to this directory.
templates_path = ['_templates']

# The suffix(es) of source filenames.
# You can specify multiple suffix as a list of string:
source_suffix = ['.rst', '.md']
#source_suffix = '.rst'

# The encoding of source tenants.
#source_encoding = 'utf-8-sig'

# The master toctree document.
master_doc = 'index'

# General information about the project.
project = u'Agave Platform'
copyright = u'2018, Rion Dooley'
author = u'Rion Dooley'

# The version info for the project you're documenting, acts as replacement for
# |version| and |release|, also used in various other places throughout the
# built documents.
#
# The short X.Y version.
version = '0.1'
# The full version, including alpha/beta/rc tags.
release = '0.1'

# The language for content autogenerated by Sphinx. Refer to documentation
# for a list of supported languages.
#
# This is also used if you do content translation via gettext catalogs.
# Usually you set "language" from the command line for these cases.
language = None

# There are two options for replacing |today|: either, you set today to some
# non-false value, then it is used:
#today = ''
# Else, today_fmt is used as the format for a strftime call.
#today_fmt = '%B %d, %Y'

# List of patterns, relative to source directory, that match tenants and
# directories to ignore when looking for source tenants.
exclude_patterns = []

# The reST default role (used for this markup: `text`) to use for all
# documents.
#default_role = None

# If true, '()' will be appended to :func: etc. cross-reference text.
#add_function_parentheses = True

# If true, the current module name will be prepended to all description
# unit titles (such as .. function::).
#add_module_names = True

# If true, sectionauthor and moduleauthor directives will be shown in the
# output. They are ignored by default.
#show_authors = False

# The name of the Pygments (syntax highlighting) style to use.
pygments_style = 'sphinx'

# A list of ignored prefixes for module index sorting.
#modindex_common_prefix = []

# If true, keep warnings as "system message" paragraphs in the built documents.
#keep_warnings = False

# If true, `todo` and `todoList` produce output, else they produce nothing.
todo_include_todos = False


# -- Options for HTML output ----------------------------------------------

# The theme to use for HTML and HTML Help pages.  See the documentation for
# a list of builtin themes.
#html_theme = 'alabaster'

# Theme options are theme-specific and customize the look and feel of a theme
# further.  For a list of options available for each theme, see the
# documentation.
html_theme_options = {
    'canonical_url': '',
    'analytics_id': '',
    'logo_only': False,
    'display_version': True,
    'prev_next_buttons_location': 'bottom',
    'style_external_links': True,
    # 'vcs_pageview_mode': 'blob',
    # Toc options
    'collapse_navigation': True,
    'sticky_navigation': False,
    'navigation_depth': 3,
    'includehidden': True,
    'titles_only': False
}

# html_theme = 'guzzle_sphinx_theme'
html_theme = 'sphinx_rtd_theme'




# # Register the theme as an extension to generate a sitemap.xml
# extensions.append("guzzle_sphinx_theme")
#
# # Add any paths that contain custom themes here, relative to this directory.
# html_theme_path = guzzle_sphinx_theme.html_theme_path()
#
# html_theme_options = {
#     # Set the name of the project to appear in the sidebar
#     "project_nav_name": "ATIM Docs",
# }

# The name for this set of Sphinx documents.  If None, it defaults to
# "<project> v<release> documentation".
html_title = 'Agave Platform Documentation'

# A shorter title for the navigation bar.  Default is the same as html_title.
html_short_title = 'Agave Platform'

# The name of an image file (relative to this directory) to place at the top
# of the sidebar.
html_logo = 'images/agave-platform-logo-white.png'

# The name of an image file (within the static path) to use as favicon of the
# docs.  This file should be a Windows icon file (.ico) being 16x16 or 32x32
# pixels large.
html_favicon = 'images/favicon.ico'

# Add any paths that contain custom static tenants (such as style sheets) here,
# relative to this directory. They are copied after the builtin static tenants,
# so a file named "default.css" will overwrite the builtin "default.css".
#html_static_path = ['_static']

# Add any extra paths that contain custom tenants (such as robots.txt or
# .htaccess) here, relative to this directory. These tenants are copied
# directly to the root of the documentation.
#html_extra_path = []

# If not '', a 'Last updated on:' timestamp is inserted at every page bottom,
# using the given strftime format.
#html_last_updated_fmt = '%b %d, %Y'

# If true, SmartyPants will be used to convert quotes and dashes to
# typographically correct entities.
#html_use_smartypants = True

# Custom sidebar templates, maps document names to template names.
#html_sidebars = {}

# Additional templates that should be rendered to pages, maps page names to
# template names.
#html_additional_pages = {}

# If false, no module index is generated.
#html_domain_indices = True

# If false, no index is generated.
#html_use_index = True

# If true, the index is split into individual pages for each letter.
#html_split_index = False

# If true, links to the reST sources are added to the pages.
#html_show_sourcelink = True

# If true, "Created using Sphinx" is shown in the HTML footer. Default is True.
#html_show_sphinx = True

# If true, "(C) Copyright ..." is shown in the HTML footer. Default is True.
#html_show_copyright = True

# If true, an OpenSearch description file will be output, and all pages will
# contain a <link> tag referring to it.  The value of this option must be the
# base URL from which the finished HTML is served.
#html_use_opensearch = ''

# This is the file name suffix for HTML tenants (e.g. ".xhtml").
#html_file_suffix = None

# Language to be used for generating the HTML full-text search index.
# Sphinx supports the following languages:
#   'da', 'de', 'en', 'es', 'fi', 'fr', 'hu', 'it', 'ja'
#   'nl', 'no', 'pt', 'ro', 'ru', 'sv', 'tr'
#html_search_language = 'en'

# A dictionary with options for the search language support, empty by default.
# Now only 'ja' uses this config value
#html_search_options = {'type': 'default'}

# The name of a javascript file (relative to the configuration directory) that
# implements a search results scorer. If empty, the default will be used.
#html_search_scorer = 'scorer.js'

# Output file base name for HTML help builder.
htmlhelp_basename = 'ATIMdoc'

# -- Options for LaTeX output ---------------------------------------------

latex_elements = {
# The paper size ('letterpaper' or 'a4paper').
#'papersize': 'letterpaper',

# The font size ('10pt', '11pt' or '12pt').
#'pointsize': '10pt',

# Additional stuff for the LaTeX preamble.
#'preamble': '',

# Latex figure (float) alignment
#'figure_align': 'htbp',
}

# Grouping the document tree into LaTeX tenants. List of tuples
# (source start file, target name, title,
#  author, documentclass [howto, manual, or own class]).
latex_documents = [
  (master_doc, 'ATIM.tex', u'ATIM Documentation',
   u'Rion Dooley', 'manual'),
]

# The name of an image file (relative to this directory) to place at the top of
# the title page.
#latex_logo = None

# For "manual" documents, if this is true, then toplevel headings are parts,
# not chapters.
#latex_use_parts = False

# If true, show page references after internal links.
#latex_show_pagerefs = False

# If true, show URL addresses after external links.
#latex_show_urls = False

# Documents to append as an appendix to all manuals.
#latex_appendices = []

# If false, no module index is generated.
#latex_domain_indices = True


# -- Options for manual page output ---------------------------------------

# One entry per manual page. List of tuples
# (source start file, name, description, authors, manual section).
man_pages = [
    (master_doc, 'atim', u'AIM Documentation',
     [author], 1)
]

# If true, show URL addresses after external links.
#man_show_urls = False


# -- Options for Texinfo output -------------------------------------------

# Grouping the document tree into Texinfo tenants. List of tuples
# (source start file, target name, title, author,
#  dir menu entry, description, category)
texinfo_documents = [
  (master_doc, 'ATIM', u'ATIM Documentation',
   author, 'ATIM', 'The leading Science-as-a-Service platform for the open research community.',
   'Miscellaneous'),
]

# Documents to append as an appendix to all manuals.
#texinfo_appendices = []

# If false, no module index is generated.
#texinfo_domain_indices = True

# How to display URL addresses: 'footnote', 'no', or 'inline'.
#texinfo_show_urls = 'footnote'

# If true, do not generate a @detailmenu in the "Top" node's menu.
#texinfo_no_detailmenu = False

rst_prolog = """
.. |project| replace:: The Agave Platform
.. _project: https://agaveplatform.org

.. |website| replace:: The Agave Website
.. _Website: http://agaveplatform.org

.. |developer docs| replace:: Developer Documentation
.. _developer docs: https://docs.agaveplatform.org

.. |project_support_url| replace:: https://github.com/agaveplatform/deployer/issues
.. |project_support| replace:: Support
.. _project_support: https://github.com/agaveplatform/deployer/issues

.. _tenant: https://sandbox.agaveplatform.org 
.. |tenant| replace:: Sandbox
.. |tenant_url| replace:: https://sandbox.agaveplatform.org
.. |tenant_id| replace:: sandbox

.. _togo: https://togo.agaveplatform.org
.. |togo| replace:: Agave ToGo
.. |togo_url| replace:: https://togo.agaveplatform.org

.. _microsites: https://microsites.agaveplatform.org
.. |microsites| replace:: Agave Microsites
.. |microsite_url| replace:: https://togo.agaveplatform.org

.. _cli: https://github.com/agaveplatform.org/agave-cli
.. |cli| replace:: Agave CLI
.. |cli_url| replace:: https://github.com/agaveplatform.org/agave-cli

.. _php_sdk: http://github.com/agaveplatform.org/php-sdk
.. |php_sdk| replace:: Agave PHP SDK
.. |php_sdk_url| replace:: http://github.com/agaveplatform.org/php-sdk

.. _python_sdk: http://github.com/agaveplatform.org/python-sdk
.. |python_sdk| replace:: http://github.com/agaveplatform.org/python-sdk
.. |python_sdk_url| replace:: http://github.com/agaveplatform.org/python-sdk

.. _angularjs_sdk: http://github.com/agaveplatform.org/angularjs-sdk
.. |angularjs_sdk| replace:: http://github.com/agaveplatform.org/angularjs-sdk
.. |angularjs_sdk_url| replace:: http://github.com/agaveplatform.org/angularjs-sdk

.. _r_sdk: http://github.com/agaveplatform.org/r-sdk
.. |r_sdk| replace:: http://github.com/agaveplatform.org/r-sdk
.. |r_sdk_url| replace:: http://github.com/agaveplatform.org/r-sdk

.. _java_sdk: http://github.com/agaveplatform.org/java-sdk
.. |java_sdk| replace:: http://github.com/agaveplatform.org/java-sdk
.. |java_sdk_url| replace:: http://github.com/agaveplatform.org/java-sdk

.. _slackin: https://slackin.agaveapi.co
.. |slackin| replace:: Agave Slack Channel
.. |slackin_url| replace:: https://slackin.agaveapi.co

.. _mysql: https://dev.mysql.com/
.. |mysql| replace:: MySQL

.. _mongo: https://www.mongodb.com/
.. _mongodb: https://www.mongodb.com/
.. |mongo| replace:: MongoDB
.. |mongodb| replace:: MongoDB

.. _traefik: https://docs.traefik.io/
.. |traefik| replace:: Traefik

.. _wso2: https://wso2.com/
.. |wso2| replace:: WSO2

.. _am: https://wso2.com/api-management/
.. |am| replace:: WSO2 API Manager
.. |apim| replace:: API Manager

.. _am docs replace:: https://docs.wso2.com/display/AM190/
.. |am docs| replace:: WSO2 API Manager Documentation

.. _is: https://wso2.com/identity-and-access-management
.. |is| replace:: WSO2 Identity Server

.. _is docs: https://docs.wso2.com/display/IS190/
.. |is docs| replace:: WSO2 Identity Server Documentation



"""
#.. |caution| image:: warning.png :alt: Warning!
#.. |danger| image:: danger.png :alt: Alert!
#.. |info| image:: info.png :alt: FYI!
#.. |project_logo| image:: 'images/agave-platform-logo.png' :alt: The Agave Platform
