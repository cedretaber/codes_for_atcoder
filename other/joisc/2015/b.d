import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    S ~= S;

    auto cs = new int[][](3, 4^^N*2);
    foreach (i; 0..4^^N*2) {
        if (i) {
            static foreach (j; 0..3) cs[j][i] = cs[j][i-1];
        }
        switch (S[i]) {
            case 'J': ++cs[0][i]; break;
            case 'O': ++cs[1][i]; break;
            case 'I': ++cs[2][i]; break;
            default:
        }
    }

    auto rs = new int[][](11, 4^^N*2);
    foreach (k; 1..11) {
        auto min_r = int.max;
        auto d = 4^^(k-1);
        foreach (i; 0..4^^N*2-d*4) {
            auto r = d*3 + rs[k-1][i+d*3];
            r -= cs[0][i+d-1] - (i ? cs[0][i-1] : 0);
            r -= cs[1][i+d*2-1] - cs[1][i+d-1];
            r -= cs[2][i+d*3-1] - cs[2][i+d*2-1];
            rs[k][i] = r;
            min_r = min(min_r, r);
        }
        if (k == N) {
            writeln(min_r);
            return;
        }
    }
}