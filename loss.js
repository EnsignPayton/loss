function isLoss(i, j, size) {
  const isFrame = (dim) => [0, size - 1, Math.floor(size / 2)].includes(dim);
  const isPart = (dim, num, den) => dim === Math.floor(num * size / den);
  const isPartSet = (dim, nums, den) => nums.some((num) => isPart(dim, num, den));

  return (isFrame(i) || isFrame(j))
    || (isPartSet(j, [1, 4], 6) && !isPartSet(i, [1, 5, 7, 11], 12))
    || (isPart(j, 2, 6) && isPartSet(i, [8, 9, 10], 12))
    || (isPart(j, 5, 6) && isPartSet(i, [3, 4], 12))
    || (isPart(i, 5, 6) && isPartSet(j, [9, 10], 12));
}

function build(size) {
  const result = [];
  for (let i = 0; i < size; i++) {
    const row = [];
    for (let j = 0; j < size; j++) {
      row.push(isLoss(i, j, size));
    }
    result.push(row);
  }
  return result;
}

function print(arr, char) {
  for (const row of arr) {
    console.log(row.map((x) => x ? char : ' ').join(' '));
  }
}

const loss = build(13);
print(loss, '#');
