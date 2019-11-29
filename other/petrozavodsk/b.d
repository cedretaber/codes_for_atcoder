import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(long, "a", long, "b");
AB[10000] ABS;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);

    foreach (i; 0..N) {
        ABS[i] = AB(AS[i], BS[i]);
    }
    sort!"a.a - a.b < b.a - b.b"(ABS[0..N]);
    int j = N-1;
    foreach (i; 0..N) {
        if (ABS[i].a >= ABS[i].b) break;
        auto d = (ABS[i].b - ABS[i].a) / 2;
        ABS[i].a = ABS[i].b;
        while (d) {
            if (ABS[j].a <= ABS[j].b) {
                ABS[j].b += d;
                d = 0;
            } else if (ABS[j].a - ABS[j].b < d) {
                d -= ABS[j].a - ABS[j].b;
                ABS[j].b = ABS[j].a;
                --j;
            } else {
                ABS[j].b += d;
                d = 0;
            }
        }
    }
    foreach (ab; ABS[0..N]) {
        if (ab.a > ab.b) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}