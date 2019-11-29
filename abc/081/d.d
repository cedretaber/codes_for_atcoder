import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    size_t max_p, min_p;
    int max_a = int.min, min_a = int.max;
    foreach (i, a; as) {
        if (a > max_a) {
            max_a = a;
            max_p = i;
        }
        if (a < min_a) {
            min_a = a;
            min_p = i;
        }
    }

    writeln(N * 2 - 1);

    if (abs(max_a) > abs(min_a)) {
        foreach (i; 0..N) writefln("%s %s", max_p+1, i+1);
        foreach (i; 0..N-1) writefln("%s %s", i+1, i+2);
    } else {
        foreach (i; 0..N) writefln("%s %s", min_p+1, i+1);
        foreach_reverse (i; 1..N) writefln("%s %s", i+1, i);
    }
}