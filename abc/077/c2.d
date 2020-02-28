import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    auto CS = readln.split.to!(int[]);
    sort(AS);
    sort(BS);
    sort(CS);

    long res;
    foreach (b; BS) {
        long l, r = N;
        if (AS[0] >= b) continue;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (AS[m] < b) {
                l = m;
            } else {
                r = m;
            }
        }
        auto a = r;
        l = 0;
        r = N;
        if (CS[0] > b) r = 0;
        while (l+1 < r) {
            auto m = (l+r)/2;
            if (CS[m] <= b) {
                l = m;
            } else {
                r = m;
            }
        }
        auto c = N - r;
        res += a * c;
    }
    writeln(res);
}