import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(long, "a", long, "b");

AB[10^^5] ABS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        ABS[i] = AB(ab[0], ab[1]);
    }
    sort!"a.a < b.a"(ABS[0..N]);

    long r;
    foreach (ab; ABS[0..N]) {
        if (ab.b >= M) {
            r += ab.a * M;
            break;
        } else {
            M -= ab.b;
            r += ab.a * ab.b;
        }
    }
    writeln(r);
}