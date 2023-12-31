local T = require("utils.table")
local M = require("utils.buffer")
local assert = require("luassert")
local mock = require("luassert.mock")
local stub = require("luassert.stub")

describe("buffer", function()
  describe("is_under_cursor", function()
    local api
    before_each(function()
      api = mock(vim.api, true)
    end)
    it("50:50 from 1:0 to 100:100", function()
      api.nvim_win_get_cursor.returns({ 50, 50 })
      assert(M.is_under_cursor({ 1, 0 }, { 100, 100 }))
    end)

    it("50:50 from 75:75 to 100:100", function()
      api.nvim_win_get_cursor.returns({ 50, 50 })
      assert(not M.is_under_cursor({ 75, 75 }, { 100, 100 }))
    end)

    it("50:50 from 50:50 to 50:50", function()
      api.nvim_win_get_cursor.returns({ 50, 50 })
      assert(M.is_under_cursor({ 50, 50 }, { 50, 50 }))
    end)
  end)

  describe("get_distance", function()
    describe("forward", function()
      it("from 1:0 to 100:100", function()
        local ldist, cdist = unpack(M.get_distance(1, { 1, 0 }, { 100, 100 }, 100, 100))
        assert.equals(99, ldist)
        assert.equals(100, cdist)
      end)

      it("from 100:100 to 1:0", function()
        local ldist, cdist = unpack(M.get_distance(1, { 100, 100 }, { 1, 0 }, 100, 100))
        assert.equals(1, ldist)
        assert.equals(0, cdist)
      end)

      it("from 50:50 to 75:75", function()
        local ldist, cdist = unpack(M.get_distance(1, { 50, 50 }, { 75, 75 }, 100, 100))
        assert.equals(25, ldist)
        assert.equals(75, cdist)
      end)

      it("from 50:50 to 25:25", function()
        local ldist, cdist = unpack(M.get_distance(1, { 50, 50 }, { 25, 25 }, 100, 100))
        assert.equals(75, ldist)
        assert.equals(25, cdist)
      end)

      it("from 50:50 to 50:75", function()
        local ldist, cdist = unpack(M.get_distance(1, { 50, 50 }, { 50, 75 }, 100, 100))
        assert.equals(0, ldist)
        assert.equals(25, cdist)
      end)

      it("from 50:50 to 50:25", function()
        local ldist, cdist = unpack(M.get_distance(1, { 50, 50 }, { 50, 25 }, 100, 100))
        assert.equals(100, ldist)
        assert.equals(25, cdist)
      end)
    end)

    describe("backward", function()
      it("from 0:0 to 100:100", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 1, 0 }, { 100, 100 }, 100, 100))
        assert.equals(1, ldist)
        assert.equals(0, cdist)
      end)

      it("from 100:100 to 1:0", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 100, 100 }, { 1, 0 }, 100, 100))
        assert.equals(99, ldist)
        assert.equals(100, cdist)
      end)

      it("from 50:50 to 75:75", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 50, 50 }, { 75, 75 }, 100, 100))
        assert.equals(75, ldist)
        assert.equals(25, cdist)
      end)

      it("from 50:50 to 25:25", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 50, 50 }, { 25, 25 }, 100, 100))
        assert.equals(25, ldist)
        assert.equals(75, cdist)
      end)

      it("from 50:50 to 50:75", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 50, 50 }, { 50, 75 }, 100, 100))
        assert.equals(100, ldist)
        assert.equals(25, cdist)
      end)

      it("from 50:50 to 50:25", function()
        local ldist, cdist = unpack(M.get_distance(-1, { 50, 50 }, { 50, 25 }, 100, 100))
        assert.equals(0, ldist)
        assert.equals(25, cdist)
      end)
    end)
  end)

  describe("get_cursor_distance", function()
    local api
    before_each(function()
      api = mock(vim.api, true)
    end)
    describe("forward", function()
      it("from 5:8 to 8:8", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        local ldist, cdist = unpack(M.get_cursor_distance(1, { 8, 8 }))
        assert.equals(3, ldist)
        assert.equals(8, cdist)
      end)
      it("from 5:8 to 5:15", function()
        api.nvim_win_get_cursor.returns({ 5, 8 })
        local ldist, cdist = unpack(M.get_cursor_distance(1, { 5, 15 }))
        assert.equals(0, ldist)
        assert.equals(7, cdist)
      end)
    end)
  end)

  describe("distcomp", function()
    it("{ 3, 8 } and { 0, 7 }", function()
      assert.equals(1, M.distcomp({ 3, 8 }, { 0, 7 }))
    end)
    it("{ 0, 7 } and { 3, 8 }", function()
      assert.equals(-1, M.distcomp({ 0, 7 }, { 3, 8 }))
    end)
    it("{ 3, 8 } and { 3, 8 }", function()
      assert.equals(0, M.distcomp({ 3, 8 }, { 3, 8 }))
    end)
    it("{ 3, 8 } and { 3, 9 }", function()
      assert.equals(-1, M.distcomp({ 3, 8 }, { 3, 9 }))
    end)
    it("{ 3, 8 } and { 3, 7 }", function()
      assert.equals(1, M.distcomp({ 3, 8 }, { 3, 7 }))
    end)

    it("closest in list", function()
      local list = {
        { 2, 15 },
        { 3, 8 },
        { 0, 7 },
      }
      local closest = T.compby(function(acc, curr)
        return M.distcomp(acc, curr) > 0
      end, list)
      assert.are.same({ 0, 7 }, closest)
    end)
  end)
end)
