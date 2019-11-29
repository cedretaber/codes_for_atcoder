import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(int, "a", int, "b");

AB[10^^4*5] ABS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        ABS[i] = AB(ab[0], ab[1]);
    }

    auto r1 = ABS[0].a;
    foreach (ab; ABS[1..$]) {
        r1 = max(gcd(r1, ab.a), gcd(r1, ab.b));
    }
    auto r2 = ABS[0].b;
    foreach (ab; ABS[1..$]) {
        r2 = max(gcd(r2, ab.a), gcd(r2, ab.b));
    }
    writeln(max(r1, r2));
}