h, w = map(int, input().split())
C = [input() for _ in range(h)]
seen = [[False]*w for _ in range(h)]
L = [[-1]*w for _ in range(h)]
for y in range(h):
  for x in range(w):
    if y-1>=0 and y+1<h and C[y-1][x] == C[y][x] == C[y+1][x]:
       L[y-1][x] = L[y][x] = L[y+1][x] = C[y][x]
    if x-1>=0 and x+1<w and C[y][x-1] == C[y][x] == C[y][x+1]:
      L[y][x-1] = L[y][x] = L[y][x+1] = C[y][x]
def dfs(y, x):
  stack = [(y, x)]
  seen[y][x] = True
  col = L[y][x]
  while stack:
    y, x = stack.pop()
    for dy, dx in ((-1, 0), (0, -1), (1, 0), (0, 1)):
      ny, nx = y+dy, x+dx
      if 0 <= ny < h and 0 <= nx < w:
        if seen[ny][nx]:
          continue
        if L[ny][nx] != col:
          continue
        seen[ny][nx] = True
        stack.append((ny, nx))
ans = 0
for i in range(h):
  for j in range(w):
    if not seen[i][j] and L[i][j] != -1:
      ans += 1
      dfs(i, j)
print(ans)
