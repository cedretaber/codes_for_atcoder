import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new char[][](H, W);
    int bc;
    foreach (i; 0..H) foreach (j, c; readln.chomp.to!(char[])) {
        if (c == '#') ++bc;
        MAP[i][j] = c;
    }

    auto FS = new bool[][](H, W);
    FS[0][0] = true;
    auto ss = [[0, 0, 0]];
    int cnt;
    bool ok;
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        auto x = h[0];
        auto y = h[1];
        auto c = h[2];
        if (x == W-1 && y == H-1) {
            cnt = c-1;
            ok = true;
            break;
        }
        foreach (d; [[0,1], [1,0], [-1,0], [0,-1]]) {
            auto xd = x + d[0];
            auto yd = y + d[1];
            if (xd < 0 || xd >= W || yd < 0 || yd >= H || MAP[yd][xd] == '#' || FS[yd][xd]) continue;
            FS[yd][xd] = true;
            ss ~= [xd, yd, c+1];
        }
    }

    if (!ok) {
        writeln(-1);
    } else {
        writeln(H * W - cnt - bc - 2);
    }
}