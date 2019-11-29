import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);
    sort!"a < b"(AS);
    auto FS = readln.split.to!(long[]);
    sort!"a > b" (FS);

    long min_r = -1, max_r = 10L^^12;
    while (min_r + 1 < max_r) {
        auto r = (min_r + max_r) / 2;
        auto k = K;
        foreach (i; 0..N) {
            auto d = r - AS[i] * FS[i];
            if (d < 0) k += (d - FS[i]+1) / FS[i];
            if (k < 0) break;
        }
        if (k >= 0) {
            max_r = r;
        } else {
            min_r = r;
        }
    }
    writeln(max_r);
}