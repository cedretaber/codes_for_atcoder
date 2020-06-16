import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void solve()
{
    auto abcd = readln.split.to!(long[]);
    auto A = abcd[0];
    auto B = abcd[1];
    auto C = abcd[2];
    auto D = abcd[3];

    if (A < B || D < B) {
        writeln("No");
        return;
    }
    if (C >= B) {
        writeln("Yes");
        return;
    }
    auto g = gcd(B, D);
    writeln(A%g + B-g > C ? "No" : "Yes");
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) solve();
}