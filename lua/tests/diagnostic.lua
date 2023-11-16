local assert = require("luassert")
local mock = require("luassert.mock")
local M = require("config.diagnostic")

describe("diagnostic", function()
  describe("is_closer", function()
    describe("forward", function()
      local api
      before_each(function()
        api = mock(vim.api, true)
      end)
      it("closer second", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        local closest = M.is_closer(1, {
          col = 8,
          end_col = 13,
          end_lnum = 7,
          lnum = 7,
          severity = 4,
        }, {
          col = 15,
          end_col = 15,
          end_lnum = 4,
          lnum = 4,
          severity = 1,
        })
        assert(closest)
      end)
      it("closer first", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        local closest = M.is_closer(1, {
          col = 15,
          end_col = 15,
          end_lnum = 4,
          lnum = 4,
          severity = 1,
        }, {
          col = 8,
          end_col = 13,
          end_lnum = 7,
          lnum = 7,
          severity = 4,
        })
        assert(not closest)
      end)
    end)
  end)
end)
