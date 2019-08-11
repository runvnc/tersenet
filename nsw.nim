import nigui

import doc

app.init()

var window = newWindow("NoScript Web")

window.width = 600.scaleToDpi
window.height = 400.scaleToDpi

# icon path executable file without extension + ".png"

var mainContainer = newLayoutContainer(Layout_Vertical)
window.add(mainContainer)

var topContainer = newLayoutContainer(Layout_Vertical)
mainContainer.add(topContainer)

for i in 1..5:
  topContainer.add(newLabel("Label in topContainer #" & $i))

var scrollContainer = newLayoutContainer(Layout_Vertical)
mainContainer.add(scrollContainer)
scrollContainer.heightMode = HeightMode_Expand
scrollContainer.widthMode = WidthMode_Expand

for i in 1..25:
  scrollContainer.add(newLabel("Label in scrollContainer #" & $i)

window.show()

var root = parse"""
Heading 1
=========
Testing.
"""

app.run()
# "app.quit()".
