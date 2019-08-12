import nigui, packages/docutils/rstast, doc

app.init()

var rst = readFile("backends.rst")

var root = parse(rst)

#echo renderRstToJson(root)

var window = newWindow("NoScript Web")

window.width = 600
window.height = 400

# icon path executable file without extension + ".png"

var scrollContainer = newLayoutContainer(Layout_Vertical)
window.add(scrollContainer)

scrollContainer.widthMode = WidthMode_Expand
scrollContainer.heightMode = HeightMode_Expand

var control1 = newControl()
scrollContainer.add(control1)

control1.widthMode = WidthMode_Expand
control1.heightMode = HeightMode_Static

#control1.height = 700
#control1.width = 600

#control1.height = pageHeight

control1.onDraw = proc (event: DrawEvent) =
  render(event.control.canvas, root)
  if control1.height != pageHeight:
    echo "fix height"
    control1.height = pageHeight

window.show()

app.run()
# "app.quit()".
