import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Path = Tuple!(int, "r", int, "c");

void main()
{
    auto hwn = readln.split.to!(long[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];
    bool[Path] X;
    foreach (_; 0..N) {
        auto rc = readln.split.to!(int[]);
        auto r = (rc[0]-1) * 2;
        auto c = (rc[1]-1) * 2;
        foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {
            auto rd = r + d[0];
            auto cd = c + d[1];
            if (rd < 0 || rd > (H-1)*2 || cd < 0 || cd > (W-1)*2) continue;
            X[Path(rd, cd)] = true;
        }
    }
    writeln(H*W*2 - H - W - X.length.to!long);
}