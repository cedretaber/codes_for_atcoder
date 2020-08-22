import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]).map!"a - 1".array;
    auto cs = new int[](N);
    foreach (a; AS) ++cs[a];

    auto hs = AS[0..2];
    int res;
    foreach (idx; 0..N-1) {
        hs ~= AS[2+idx*3..5+idx*3];
        sort(hs);
        if (hs[0] == hs[1] && hs[1] == hs[2]) {
            ++res;
            cs[hs[0]] -= 3;
            hs = hs[3..5];
            continue;
        } else if (hs[1] == hs[2] && hs[2] == hs[3]) {
            ++res;
            cs[hs[1]] -= 3;
            hs = [hs[0], hs[4]];
            continue;
        } else if (hs[2] == hs[3] && hs[3] == hs[4]) {
            ++res;
            cs[hs[2]] -= 3;
            hs = hs[0..2];
            continue;
        }

        int pd;
        foreach (c; cs) pd += c/3;

        int[] ii;
        int d_max = int.min;
        foreach (i; 0..3) foreach (j; i+1..4) foreach (k; j+1..5) {
            --cs[hs[i]]; --cs[hs[j]]; --cs[hs[k]];
            int d;
            foreach (c; cs) d += c/3;
            if (d-pd > d_max) {
                ii = [i, j, k];
            }
            ++cs[hs[i]]; ++cs[hs[j]]; ++cs[hs[k]];
        }
        foreach (i; ii) --cs[hs[i]];
        int[] ns;
        foreach (i; 0..5) if (i != ii[0] && i != ii[1] && i != ii[2]) ns ~= hs[i];
        hs = ns;
    }
    hs ~= AS[$-1];
    if (hs[0] == hs[1] && hs[1] == hs[2]) ++res;
    writeln(res);
}