
import uing

var 
  window: Window

proc doSomething() =
  msgBox(window, "Done", "I did something!")

proc main = 

  let fileMenu = newMenu("File")
  fileMenu.addItem(
    "Do Something",
    proc (_: MenuItem, win: Window) = doSomething()
  )
  fileMenu.addQuitItem(
    proc (): bool =
      window.destroy()
      return true
  )

  window = newWindow("Do Something", -1, -1, true)
  window.margined = true

  let vbox = newVerticalBox(true)
  window.child = vbox

  let form = newForm(true)
  vbox.add form

  let hbox = newHorizontalBox(true)
  hbox.add newButton("Do Something") do (_: Button):
    doSomething()
  
  form.add "", hbox, true

  show window
  mainLoop()

init()
main()
