switch("amd64.macosx.clang.exe", "o64-clang")
switch("amd64.macosx.clang.linkerexe", "o64-clang")

switch("app", "gui")
switch("d", "release")
switch("opt", "speed")

if buildOS != "linux":
  echo "This is for cross compilation to linux, windows and macosx, but can only be run on a linux system."
  quit 11

when defined(windows):
  switch("out", "windows/cgui.exe")
elif defined(macosx):
  switch("out", "macosx/cgui")
else:
  switch("out", "cgui")


