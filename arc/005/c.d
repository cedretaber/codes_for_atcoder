import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    
    auto MAP = new char[][](H, W);
    size_t si, sj;
    foreach (i; 0..H) {
        foreach (j, c; readln.chomp.to!(char[])) {
            if (c == 's') {
                si = i;
                sj = j;
            }
            MAP[i][j] = c;
        }
    }
    auto MEMO = new bool[][][](H, W, 3);
    MEMO[si][sj][2] = true;
    auto ss = [[si, sj, 2]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        foreach (d; [[1,0],[0,1],[-1,0],[0,-1]]) {
            auto i = h[0] + d[0];
            auto j = h[1] + d[1];
            if (i < 0 || i >= H || j < 0 || j >= W) continue;
            auto b = h[2];
            if (MAP[i][j] == '#') {
                if (b == 0) continue;
                --b;
            } else if (MAP[i][j] == 'g') {
                writeln("YES");
                return;
            }
            if (MEMO[i][j][b]) continue;
            MEMO[i][j][b] = true;
            ss ~= [i, j, b];
        }
    }
    writeln("NO");
}