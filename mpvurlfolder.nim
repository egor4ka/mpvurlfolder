#import the necessary modules
import os, strformat, htmlparser, strtabs, xmltree, httpclient

#declare variables
var 
  client = newHttpClient()
  musicFiles = newSeq[string]()
let 
  url = commandLineParams()[0]
  file = "input.html"
  html = parseHtml(client.getContent(url))

#loop over the hrefs
for a in html.findAll("a"):
  if a.attrs.hasKey "href":
    musicFiles.add(a.attrs["href"])

#delete the ../ thingy
musicFiles.del(0)

#loop over the files and play them
for i in musicFiles:
  discard execShellCmd(fmt"mpv {url}{i}")
