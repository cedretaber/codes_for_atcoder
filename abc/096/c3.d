import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    char[][] P;
    P.length = H;
    foreach (i; 0..H) P[i] = readln.chomp.to!(char[]);

    foreach (i; 0..H) {
        foreach (j; 0..W) {
            if (P[i][j] == '.') continue;

            bool ok;
            foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
                auto x = j+d[0];
                auto y = i+d[1];
                if (x >= 0 && x < W && y >= 0 && y < H && P[y][x] == '#') {
                    ok = true;
                    break;
                }
            }
            if (!ok) {
                writeln("No");
                return;
            }
        }
    }
    writeln("Yes");
}