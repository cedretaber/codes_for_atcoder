import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;


void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] MAP;
    foreach (i; 0..H) MAP ~= readln.chomp.to!(char[]);

    auto memo = new bool[][](H, W);
    int a, b, c;
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] == 'o' && !memo[i][j]) {
        memo[i][j] = true;
        auto cnt = 1, max_h = i, min_h = i;
        auto ss = [[i, j]];
        while (!ss.empty) {
            auto t = ss[0];
            ss = ss[1..$];
            static foreach (d; [[1,1],[1,0],[1,-1],[0,1],[0,-1],[-1,1],[-1,0],[-1,-1]]) {{
                auto h = t[0]+d[0];
                auto w = t[1]+d[1];
                if (h >= 0 && h < H && w >= 0 && w < W && MAP[h][w] == 'o' && !memo[h][w]) {
                    memo[h][w] = true;
                    ++cnt;
                    max_h = max(max_h, h);
                    min_h = min(min_h, h);
                    ss ~= [h, w];
                }
            }}
        }
        auto r = (max_h - min_h + 1) / 5;
        switch (cnt / r^^2) {
            case 12: ++a; break;
            case 16: ++b; break;
            default: ++c; break;
        }
    }
 
    writeln(a, " ", b, " ", c);
}