# Package

version       = "1.0.0"
author        = "K.Kentaro"
description   = "This is a tool to make AviUtl's dll script."
license       = "MIT"
srcDir        = "src"


# Dependencies

requires "nim >= 2.2.2"
task test, "Run tests with cpp compiler":
  exec "nim cpp tests/test_library"