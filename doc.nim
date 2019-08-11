import packages/docutils/rst
import packages/docutils/rstast
import nigui
import math, times, os

const spaceWidth = 3
var x = 0
var y = 0
var size = [40f, 35f, 25f, 20f ]
var textWidth = 0
var textHeight = 0
const wScale = 0.9
var pageWidth = 570
var lastUnknown = false
var pageHeight* = 400

proc parse*(rst:string): PRstNode =
  var opts = {roSupportSmilies}
  var hasToc = false
  let time = cpuTime()
  result = rstParse(rst,"",0,0,hasToc,opts)
  echo "parse in ", (cpuTime()-time)

proc renderLeaf(canvas: Canvas, node: PRstNode) =
  textWidth = getTextLineWidth(canvas, node.text)
  if x + textWidth > pageWidth:
    x = spaceWidth
    y += textHeight

  if node.text == " ":
    x += spaceWidth
  else:
    canvas.drawText(node.text, x, y)
    textWidth = getTextLineWidth(canvas, node.text)
    x += floor(textWidth.toFloat * wScale).toInt
  lastUnknown = false

proc renderHeadline(canvas: Canvas, node: PRstNode) =
  y += (textHeight.toFloat * 1.5).toInt
  x = spaceWidth
  canvas.fontSize = size[node.level-1]
  textHeight = getTextLineHeight(canvas)
  lastUnknown = false

proc renderParagraph(canvas: Canvas, node: PRstNode) =
  canvas.fontSize = size[3]
  y += (textHeight.toFloat * 1.5).toInt
  x = spaceWidth
  textHeight = getTextLineHeight(canvas)
  lastUnknown = false

proc renderUnknown(canvas: Canvas, node: PRstNode) =
  if not lastUnknown:
    y += (textHeight.toFloat * 1.5).toInt
    x = spaceWidth
  lastUnknown = true

proc renderNode(canvas: Canvas, node: PRstNode) =
  if node == nil: return
  var dummy = 0
 
  case node.kind:
    of rnHeadline: renderHeadline(canvas, node)
    of rnParagraph: renderParagraph(canvas, node)
    of rnLeaf: renderLeaf(canvas, node)
    else: renderUnknown(canvas, node)

  for son in node.sons:
    renderNode(canvas, son)

proc render*(canvas: Canvas, root: PRstNode) =
  x = 0
  y = 0

  let time = cpuTime()
  for son in root.sons:
    renderNode(canvas, son)
  if pageHeight != y:
    pageHeight = y
  echo "render in ",(cpuTime()-time)*1000.0
