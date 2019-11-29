import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;


int walk(int i, int j, int H, int W, char[][] MAP) {
    int n;
    MAP[i][j] = '.';
    foreach (d; [[1,0],[0,1],[-1,0],[0,-1],[1,1],[1,-1],[-1,1],[-1,-1]]) {
        auto ii = i + d[0];
        auto jj = j + d[1];
        if (ii < 0 || ii >= H || jj < 0 || jj >= W) continue;
        if (MAP[ii][jj] == 'o') n += walk(ii, jj, H, W, MAP);
    }
    return n + 1;
}

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(char[]);
    }
 
    bool[int] SN;
    foreach (i; 1..1000) {
        SN[i^^2] = true;
    }
 
    int a, b, c;
    foreach (i; 0..H) foreach (j; 0..W) if (MAP[i][j] == 'o') {
        auto n = walk(i, j, H, W, MAP);
        if (n%12 == 0 && n/12 in SN) ++a;
        if (n%16 == 0 && n/16 in SN) ++b;
        if (n%11 == 0 && n/11 in SN) ++c;
    }
 
    writefln("%d %d %d", a, b, c);
}