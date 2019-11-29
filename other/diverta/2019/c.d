import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int a, b, ab, r;
    foreach (_; 0..N) {
        auto s = readln.chomp;
        if (s[0] == 'B' && s[$-1] == 'A') {
            ++ab;
        } else if (s[0] == 'B') {
            ++b;
        } else if (s[$-1] == 'A') {
            ++a;
        }
        foreach (i; 0..s.length-1) {
            if (s[i..i+2] == "AB") ++r;
        }
    }

    if (ab > 0) {
        r += ab-1;
        if (a > 0) {
            --a;
            r += 1;
        }
        if (b > 0) {
            --b;
            r += 1;
        }
    }
    r += min(a, b);

    writeln(r);
}