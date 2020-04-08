import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    int[][] ps;
    auto memo = new bool[][](H, W);
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp) {
            if (c == '#') {
                ps ~= [j.to!int, i.to!int];
                memo[i][j] = true;
            }
        }
    }
    int c = -1;
    while (!ps.empty) {
        int[][] pps;
        foreach (p; ps) {
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto x = p[0]+d[0];
                auto y = p[1]+d[1];
                if (x < 0 || x >= W || y < 0 || y >= H || memo[y][x]) continue;
                memo[y][x] = true;
                pps ~= [x, y];
            }
        }
        ps = pps;
        ++c;
    }
    writeln(c);
}