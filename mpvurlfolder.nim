#import the necessary modules
import os, strformat, htmlparser, strtabs, xmltree

#declare variables
let 
  url = commandLineParams()[0]
  file = "input.html"
var musicFiles = newSeq[string]()

discard execShellCmd(fmt"curl -so {file} {url}")

#declare the html variable because it must be ran after the curl
let html = loadHtml(file)

#loop over the hrefs
for a in html.findAll("a"):
  if a.attrs.hasKey "href":
    musicFiles.add(a.attrs["href"])

#delete the ../ thingy
musicFiles.del(0)

#loop over the files and play them
for i in musicFiles:
  discard execShellCmd(fmt"mpv {url}{i}")

#remove the curled file
removeFile(file)
