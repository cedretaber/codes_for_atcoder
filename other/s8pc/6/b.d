import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = new long[](N);
    auto BS = new long[](N);

    long x;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        AS[i] = ab[0];
        BS[i] = ab[1];
        x += ab[1] - ab[0];
    }
    sort(AS);
    sort(BS);

    auto A = AS[N/2];
    foreach (a; AS) x += abs(a - A);
    auto B = BS[N/2];
    foreach (b; BS) x += abs(b - B);

    writeln(x);
}