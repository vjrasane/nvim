function RQ(module)
  package.loaded[module] = false
  return require(module)
end

function REF(module)
  return function()
    return RQ(module)
  end
end
