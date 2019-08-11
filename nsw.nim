import nigui, packages/docutils/rstast, doc

app.init()

var rst = readFile("notworking.rst")

var root = parse(rst)

#echo renderRstToJson(root)

var window = newWindow("NoScript Web")

window.width = 600.scaleToDpi
window.height = 400.scaleToDpi

# icon path executable file without extension + ".png"

var scrollContainer = newLayoutContainer(Layout_Vertical)
window.add(scrollContainer)

var control1 = newControl()
scrollContainer.widthMode = WidthMode_Expand
scrollContainer.heightMode = HeightMode_Expand
# Let it fill out the whole window
scrollContainer.add(control1)
# Creates a drawable control

control1.height = 700
control1.width = 600
control1.widthMode = WidthMode_Expand
control1.heightMode = HeightMode_Static

var gotCanvas = false

control1.onDraw = proc (event: DrawEvent) =
  let canvas = event.control.canvas
  if not gotCanvas:
    canvas.textColor = rgb(0, 0, 0)
    canvas.fontSize = 20
    canvas.fontFamily = "Arial"
   
    canvas.areaColor = rgb(250, 250, 250)
    canvas.fill()
    gotCanvas = true

  render(canvas, root)
  if control1.height != pageHeight:
    control1.height = pageHeight

window.show()


app.run()
# "app.quit()".
