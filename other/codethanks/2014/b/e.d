import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto R = rc[0];
    auto C = rc[1];
    auto src = readln.split.to!(int[]);
    auto sr = src[0]-1;
    auto sc = src[1]-1;
    auto grc = readln.split.to!(int[]);
    auto gr = grc[0]-1;
    auto gc = grc[1]-1;
    auto MAP = new bool[][](R, C);
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto rchw = readln.split.to!(int[]);
        auto r = rchw[0]-1;
        auto c = rchw[1]-1;
        auto h = rchw[2];
        auto w = rchw[3];
        foreach (i; r..r+h) {
            foreach (j; c..c+w) {
                MAP[i][j] = true;
            }
        }
    }
    if (!MAP[sr][sc] || !MAP[gr][gc]) {
        writeln("NO");
        return;
    }

    auto ss = [[sr, sc]];
    while (!ss.empty) {
        auto s = ss[0];
        ss = ss[1..$];
        foreach (d; [[1,0], [0,1], [-1,0], [0, -1]]) {
            auto r = s[0]+d[0];
            auto c = s[1]+d[1];
            if (r < 0 || r >= R || c < 0 || c >= C || !MAP[r][c]) continue;
            if (r == gr && c == gc) {
                writeln("YES");
                return;
            }
            MAP[r][c] = false;
            ss ~= [r, c];
        }
    }
    writeln("NO");
}