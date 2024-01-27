return {
  "echasnovski/mini.indentscope",
  opts = {
    draw = {
      animation = function(_n, total)
        if total > 40 then
          return 1
        elseif total > 30 then
          return 2
        elseif total > 20 then
          return 5
        end
        return 15
      end,
    },
  },
}
