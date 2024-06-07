local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

return {
  s(
    {
      trig = "func",
      dscr = "naked function",
    },
    fmt([[
      function({})
        {}
      end{}]],
      { i(1), i(2), i(0) }
    )
  ),
  ls.parser.parse_snippet("lf", "local $1 = function($2)\n\t$0\nend"),
  ls.parser.parse_snippet("mf", "$1.$2 = function($3)\n\t$0\nend"),
  s("lreq", fmt([[local {} = require("{}")]], { i(1), rep(1) } )),
  s("lo", fmt([[local {} = {}]], { i(1), i(0) } )),
}
