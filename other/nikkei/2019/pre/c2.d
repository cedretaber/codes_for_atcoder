import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias AB = Tuple!(long, "a", long, "b");

AB[10^^5] ABS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(long[]);
        ABS[i] = AB(ab[0], ab[1]);
    }
    sort!"(a.a + a.b) > (b.a + b.b)"(ABS[0..N]);
    

    int t;
    long sum_a, sum_b;
    auto abs = ABS[0..N];
    foreach (_; 0..N) {
        ++t;
        auto head = abs[0];
        abs = abs[1..$];
        if (t % 2 == 1) {
            sum_a += head.a;
        } else {
            sum_b += head.b;
        }
    }
    writeln(sum_a - sum_b);
}