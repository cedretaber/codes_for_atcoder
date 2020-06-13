import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto AS = readln.split.to!(long[]);
    AS ~= 0;

    foreach (_; 0..K) {
        auto BS = new long[](N+1);
        foreach (i, a; AS) {
            BS[max(0, i.to!long - a)] += 1;
            BS[min(N, i.to!long + a + 1)] -= 1;
        }
        auto all = true;
        long n;
        foreach (i, ref b; BS) {
            n += b;
            if (i != N && n != N) all = false;
            b = n;
        }
        AS = BS;
        if (all) break;
    }

    writeln(AS[0..$-1].to!(string[]).join(" "));
}