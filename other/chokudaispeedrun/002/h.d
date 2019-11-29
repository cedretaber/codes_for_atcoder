import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(size_t, "i", long, "a", long, "b");

AB[10^^5*2] ABS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        ABS[i] = AB(i, ab[0], ab[1]);
    }
    sort!"(a.a - 1) * a.b > (b.a - 1) * b.b"(ABS[0..N]);
    foreach (ab; ABS[1..N]) {
        if ((ABS[0].a - 1) / ab.b <= (ab.a - 1) / ABS[0].b ) {
            writeln("-1");
            return;
        }
    }
    writeln(ABS[0].i + 1);
}