local diagnostics = {
  {

    col = 15,
    end_col = 15,
    end_lnum = 4,
    lnum = 4,

    severity = 1,
  },
  {

    col = 15,
    end_col = 15,
    end_lnum = 7,
    lnum = 7,
    severity = 1,
  },
  {

    col = 9,
    end_col = 10,
    end_lnum = 2,
    lnum = 2,

    severity = 3,
  },
  {

    col = 6,
    end_col = 9,
    end_lnum = 1,
    lnum = 1,

    severity = 4,
  },
  {

    col = 8,
    end_col = 11,
    end_lnum = 3,
    lnum = 3,

    severity = 4,
  },
  {

    col = 8,
    end_col = 13,
    end_lnum = 4,
    lnum = 4,

    severity = 4,
  },
  {

    col = 8,
    end_col = 13,
    end_lnum = 5,
    lnum = 5,

    severity = 4,
  },
  {

    col = 8,
    end_col = 14,
    end_lnum = 6,
    lnum = 6,

    severity = 4,
  },
  {

    col = 8,
    end_col = 13,
    end_lnum = 7,
    lnum = 7,

    severity = 4,
  },
  {

    col = 8,
    end_col = 11,
    end_lnum = 3,
    lnum = 3,

    severity = 4,
  },
  {

    col = 8,
    end_col = 13,
    end_lnum = 5,
    lnum = 5,

    severity = 4,
  },
  {
    col = 8,
    end_col = 13,
    end_lnum = 7,
    lnum = 7,

    severity = 4,
  },
  {
    col = 12,
    end_col = 21,
    end_lnum = 1,
    lnum = 1,
    severity = 2,
  },
  {
    col = 14,
    end_col = 23,
    end_lnum = 3,
    lnum = 3,
    severity = 2,
  },
}

local assert = require("luassert")
local mock = require("luassert.mock")
local stub = require("luassert.stub")
local T = require("utils.table")
local M = require("config.diagnostic")

local function filter_severities(group, ds)
  return T.filter(function(diagnostic)
    return T.includes(diagnostic.severity, group)
  end, ds)
end

describe("diagnostic", function()
  describe("get_diagnostic", function()
    describe("forward", function()
      local api
      local diagnostic
      before_each(function()
        api = mock(vim.api, true)
        diagnostic = mock(vim.diagnostic, true)
      end)
      it("on the same line", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        diagnostic.get.returns(filter_severities({ 1, 2 }, diagnostics))

        local result = M.get_diagnostic(1)
        assert.are.same({ lnum = 4, col = 15 }, result)
      end)
    end)
  end)

  describe("get_closest", function()
    describe("forward", function()
      local api
      before_each(function()
        api = mock(vim.api, true)
      end)

      it("on the same line", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        local closest = M.get_closest(1, diagnostics)
        assert(closest)
        assert.are.same({ lnum = 4, col = 15 }, closest)
      end)
    end)
  end)

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
