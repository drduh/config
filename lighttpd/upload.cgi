#!/usr/bin/env python3
# https://github.com/drduh/config/blob/master/lighttpd/upload.cgi
# Simple file uploader
# Put into /var/www/cgi-bin/, make executable and enable CGI

import cgi
import os

CHUNK_SIZE = 100000
UPLOAD = "/var/www/upload/"

HEADER = """
<html><head><title>%s</title>
<style type="text/css">
  body {
    background-color: #002b36;
    color: #839496;
    font-family: "Open Sans", "Helvetica Neue", 
      "Helvetica", "Arial", "sans-serif";
  }
  div {
    background-color: #073642;
    border-radius: 0.5em;
    margin: 1em auto;
    padding: 2em;
    width: 600px;
  }
  h1 {
    font-size: 2em;
    padding-bottom: 1em;
  }
  </style>
</head><body><div>"""
ERROR = """
<h1>Error: %s</h1>
</div></body></html>"""
SUCCESS = """
<h1>Saved <a href="../upload/%s">%s</a></h1>
<h2><a href="../index.html">Upload another file</a></h2>
<h2><a href="../upload/">Download files</a></h2>
</div></body></html>"""


def main():
    """File uploader static pages and form handler."""
    print(HEADER % "File upload")

    form = cgi.FieldStorage()
    ff = form["file"]
    fl = ff.file
    fn = ff.filename

    if not fn:
        print(ERROR % "No file selected")
        return

    with open(
        os.path.join(
            UPLOAD, os.path.basename(fn)), "wb") as out:
        while True:
            content = fl.read(CHUNK_SIZE)
            if not content:
                break
            out.write(content)

    print(SUCCESS % (fn, fn))

if __name__ == "__main__":
    main()
