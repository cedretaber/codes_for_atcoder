import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] MAP;
    foreach (_; 0..H) MAP ~= readln.chomp.to!(char[]);
    auto MEMO = new int[][](H, W);
    foreach (ref memo; MEMO) memo[] = int.max;
    auto ss = [[0, 0, MAP[0][0] == '#' ? 1 : 0]];
    while (!ss.empty) {
        auto h = ss[0];
        ss = ss[1..$];
        auto i = h[0];
        auto j = h[1];
        foreach (d; [[1,0], [0,1]]) {
            auto k = i+d[0];
            auto l = j+d[1];
            auto c = h[2];
            if (k >= H || l >= W) continue;
            if (MAP[i][j] == '.' && MAP[k][l] == '#') ++c;
            if (MEMO[k][l] <= c) continue;
            MEMO[k][l] = c;
            ss ~= [k, l, c];
        }
    }
    writeln(MEMO[H-1][W-1]);
}