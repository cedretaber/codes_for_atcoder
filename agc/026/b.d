import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void solve()
{
    auto abcd = readln.split.to!(long[]);
    auto A = abcd[0];
    auto B = abcd[1];
    auto C = abcd[2];
    auto D = abcd[3];

    if (A < B) {
        writeln("No");
        return;
    }

    auto s = A % B;
    auto d = D - B;
    if (d < 0) {
        writeln("No");
        return;
    } else if (d == 0) {
        writeln(A % B < C ? "No" : "Yes");
        return;
    }
    auto x = (C / d) * d + d;
    if (x < B) {
        writeln("No");
    } else {
        writeln("Yes");
    }
    return;
}

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) solve();
}