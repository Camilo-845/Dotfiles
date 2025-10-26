local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmt

return {

  -- Función básica
  s(
    "def",
    fmt(
      [[
  def {}({}):
      {}
  ]],
      {
        i(1, "func_name"),
        i(2, "args"),
        i(3, "pass"),
      }
    )
  ),

  -- Clase
  s(
    "class",
    fmt(
      [[
  class {}({}):
      def __init__(self, {}):
          {}
  ]],
      {
        i(1, "ClassName"),
        c(2, { t("object"), t("BaseClass") }),
        i(3, "self"),
        i(4, "pass"),
      }
    )
  ),

  -- if __name__ == '__main__'
  s(
    "main",
    t({
      "if __name__ == '__main__':",
      "    ",
    })
  ),

  -- print()
  s("p", fmt("print({})", { i(1) })),

  -- with open()
  s(
    "open",
    fmt(
      [[
  with open("{}", "{}") as {}:
      {}
  ]],
      {
        i(1, "filename.txt"),
        c(2, { t("r"), t("w"), t("a"), t("rb"), t("wb") }),
        i(3, "f"),
        i(4, "pass"),
      }
    )
  ),
}
