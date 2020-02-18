import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias K = Tuple!(int, "d", bool, "is_t");

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto H = nk[1];
    K[] ks;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        ks ~= K(ab[0], false);
        ks ~= K(ab[1], true);
    }
    sort!"a.d > b.d"(ks);
    int r;
    while (H > 0) {
        auto k = ks[0];
        if (k.is_t) {
            ++r;
            H -= k.d;
            ks = ks[1..$];
        } else {
            r += (H + k.d - 1) / k.d;
            break;
        }
    }
    writeln(r);
}