
requires "uing"

bin = @["cgui"]
version       = "0.1.0"

requires "nim >= 2.0.0"
requires "uing#head"

task osx, "Build for mac os x":
  exec "nim c --os:macosx cgui.nim"

task windows, "Build for Windows":
  exec "nim c --os:windows cgui.nim"


