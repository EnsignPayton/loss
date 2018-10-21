local floor = math.floor

function isFrame(dim, size)
    return dim == 0 or dim == size - 1 or dim == floor(size / 2)
end

function isPart(dim, num, den, size)
    return dim == floor(num * size / den);
end

function isPartSet(dim, nums, den, size)
    for _, num in pairs(nums) do
        if isPart(dim, num, den, size) then return true end
    end
    return false
end

function isLoss(i, j, size)
    return isFrame(i, size) or isFrame(j, size)
        or (isPartSet(j, {1, 4}, 6, size) and not isPartSet(i, {1, 5, 7, 11}, 12, size))
        or (isPart(j, 2, 6, size) and isPartSet(i, {8, 9, 10}, 12, size))
        or (isPart(j, 5, 6, size) and isPartSet(i, {3, 4}, 12, size))
        or (isPart(i, 5, 6, size) and isPartSet(j, {9, 10}, 12, size))
end

function build(size)
    local result = {}
    for i = 1, size do
        local row = {}
        for j = 1, size do
            row[j] = isLoss(i - 1, j - 1, size)
        end
        result[i] = row;
    end
    return result
end

function printLoss(arr, char)
    for _, row in ipairs(arr) do
        local line = ""
        for _, x in ipairs(row) do
            line = line .. (x and char or " ") .. " "
        end
        print(line)
    end
end

local loss = build(13)
printLoss(loss, "#")
