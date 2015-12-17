Blog
====

This section describes how to create a new blog entry


Create
------

New blog posts are created by the command line:

.. code-block:: bash

   cd <project-dir>/src

   hugo new blog/bika-partnership.md

.. note:: The `hugo` command knows that it has to go into the `contents` folder.



.. code-block:: toml

    +++
    author = "RIDING BYTES"
    categories = ["Web", "Development", "JS", "ExtJS", "Plone"]
    date = "2015-12-17T21:53:09+01:00"
    description = ""
    draft = true
    title = "bika partnership"
    img = "bika-partnership.jpg"
    +++

The `image` is located in `src/content/media`
