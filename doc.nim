import packages/docutils/rst
import packages/docutils/rstast
import nigui
import math, times, os, strutils

const spaceWidth = 3
var x = 0
var y = 0
var size = [40f, 35f, 25f, 20f ]
var textWidth = 0
var textHeight = 22
const wScale = 0.9
var pageWidth = 570
var lastUnknown = false
var pageHeight* = 400
var drawTextCalls = 0
var lineWidth = 0
var textRun = false
var words: seq[string] = @[]
var level = 3
var scrollY = 0
var controlHeight = 500
var firstPass = true

proc parse*(rst:string): PRstNode =
  var opts = {roSupportSmilies}
  var hasToc = false
  let time = cpuTime()
  result = rstParse(rst,"",0,0,hasToc,opts)
  echo "parse in ", (cpuTime()-time)

proc splitLines(canvas: Canvas) : seq[string] =
  var textWidth = 0
  var line = ""
  var lines:seq[string] = @[]
  var n = 0
  for word in words:
    n += 1
    line &= word
    textWidth = getTextLineWidth(canvas, line)
    if (n == len(words)) or (textWidth > pageWidth):
      for subline in line.splitLines():
        lines.add(subline)
      line = ""
  lineWidth = textWidth
  return lines    

proc inView():bool =
  let startY = scrollY
  let endY = scrollY + controlHeight
  #echo startY, ",", endY, ", ", scrollY
  result = (y >= startY and y <= endY)

proc renderLeaf(canvas: Canvas) =
  if x > pageWidth:
    x = spaceWidth
    y += (textHeight.toFloat * 1.5).toInt

  var lines = splitLines(canvas)
  for line in lines:
    canvas.fontSize = size[level-1]
    if inView():
      canvas.drawText(line, x, y)
      drawTextCalls += 1
    if len(lines) != 1:
      y += textHeight
      #x = floor(textWidth.toFloat * wScale).toInt
      x = spaceWidth
    else:
      x += lineWidth

  lastUnknown = false

proc renderHeadline(canvas: Canvas, node: PRstNode) =
  y += (textHeight.toFloat * 1.5).toInt
  x = spaceWidth
  canvas.fontSize = size[node.level-1]
  level = node.level
  #textHeight = getTextLineHeight(canvas)
  textHeight = 30
  lastUnknown = false

proc renderParagraph(canvas: Canvas, node: PRstNode) =
  canvas.fontSize = size[3]
  level = 3
  y += (textHeight.toFloat * 1.5).toInt
  x = spaceWidth
  #textHeight = getTextLineHeight(canvas)
  textHeight = 22
  lastUnknown = false

proc renderUnknown(canvas: Canvas, node: PRstNode) =
  #echo node.kind
  level = 3
  if not lastUnknown:
    x += spaceWidth
    #textHeight = getTextLineHeight(canvas)
    #textHeight = 22
    #y += (textHeight.toFloat * 1.5).toInt
    #x = spaceWidth
  lastUnknown = true

proc renderNode(canvas: Canvas, node: PRstNode) =
  if firstPass and not inView(): return
  if node == nil: return
  #echo node.kind
  var dummy = 0
  var foundText = false

  if textRun and node.kind != rnLeaf:
    renderLeaf(canvas)
    textRun = false

  case node.kind:
    of rnHeadline: renderHeadline(canvas, node)
    of rnParagraph: renderParagraph(canvas, node)
    of rnLeaf:
      if not textRun:
        textRun = true
        words = newSeq[string]()
      foundText = true
      words &= node.text
    else: renderUnknown(canvas, node)

  if not foundText: textRun = false

  for son in node.sons:
    renderNode(canvas, son)

proc render*(canvas: Canvas, root: PRstNode, scrollPos:int) =
  x = 0
  y = 0
  scrollY = scrollPos
  var n = 0
  textRun = false
  words = newSeq[string]()
  level = 3

  drawTextCalls = 0

  let time = cpuTime()
  for son in root.sons:
    n += 1
    renderNode(canvas, son)

  if pageHeight < y:
    pageHeight = y + 100
  echo "render in ",(cpuTime()-time)*1000.0
  echo "total drawText calls: ",drawTextCalls
  firstPass = false
  
