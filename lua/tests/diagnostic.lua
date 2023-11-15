-- print("hello")

local M = require("config.diagnostic")
--
-- do
-- end

describe("get_distance", function()
  it("from 0:0 to 100:100", function()
    local ldist, cdist = M.get_distance(1, { 0, 0 }, { 100, 100 }, 100, 100)
    assert.equals(100, ldist)
    assert.equals(100, cdist)
  end)

  it("from 50:50 to 75:75", function()
    local ldist, cdist = M.get_distance(1, { 50, 50 }, { 75, 75 }, 100, 100)
    assert.equals(25, ldist)
    assert.equals(75, cdist)
  end)

  it("from 50:50 to 25:25", function()
    local ldist, cdist = M.get_distance(1, { 50, 50 }, { 25, 25 }, 100, 100)
    assert.equals(75, ldist)
    assert.equals(25, cdist)
  end)

  it("from 50:50 to 50:75", function()
    local ldist, cdist = M.get_distance(1, { 50, 50 }, { 50, 75 }, 100, 100)
    assert.equals(0, ldist)
    assert.equals(25, cdist)
  end)

  it("from 50:50 to 50:25", function()
    local ldist, cdist = M.get_distance(1, { 50, 50 }, { 50, 25 }, 100, 100)
    assert.equals(100, ldist)
    assert.equals(25, cdist)
  end)
end)
