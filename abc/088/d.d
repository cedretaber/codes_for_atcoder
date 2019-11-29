import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] MAP;
    MAP.length = H;
    foreach (i; 0..H) {
        MAP[i] = readln.chomp.to!(wchar[]);
    }

    int cnt;
    foreach (l; MAP)
        foreach (e; l)
            if (e == '.') ++cnt;

    bool[][] FLG;
    FLG.length = H;
    foreach (ref l; FLG) l.length = W;

    int[2][] SS;
    SS ~= [0, 0];

    int stp;
    bool can;
    while (!SS.empty) {
        int[2][] NSS;
        foreach (ss; SS) {
            auto x = ss[0];
            auto y = ss[1];

            if (MAP[y][x] == '#' || FLG[y][x]) continue;
            FLG[y][x] = true;

            if (x == W-1 && y == H-1) {
                can = true;
                break;
            }

            if (x > 0) NSS ~= [x-1, y];
            if (x < W-1) NSS ~= [x+1, y];
            if (y > 0) NSS ~= [x, y-1];
            if (y < H-1) NSS ~= [x, y+1];
        }
        SS = NSS;
        ++stp;
        if (can) break;
    }
    if (can)
        writeln(cnt - stp);
    else
        writeln("-1");
}