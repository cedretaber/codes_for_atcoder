import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];

    wchar[][] ss;
    ss.length = H;
    foreach (i; 0..H) ss[i] = readln.chomp.to!(wchar[]);

    int[][] ns;
    ns.length = H;
    foreach (ref n; ns) n.length = W;

    foreach (y, s; ss) {
        foreach (x, e; s) {
            if (e == '#') {
                ns[y][x] = -100;
                if (x > 0) {
                    if (y > 0) ++ns[y-1][x-1];
                    ++ns[y][x-1];
                    if (y+1 < H) ++ns[y+1][x-1];
                }
                if (y > 0) ++ns[y-1][x];
                if (y+1 < H) ++ns[y+1][x];
                if (x+1 < W) {
                    if (y > 0) ++ns[y-1][x+1];
                    ++ns[y][x+1];
                    if (y+1 < H) ++ns[y+1][x+1];
                }
            }
        }
    }

    foreach (n; ns) {
        foreach (e; n) {
            write(e < 0 ? "#" : e.to!string);
        }
        writeln("");
    } 
}