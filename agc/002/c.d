import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    long L = nl[1];
    auto as = readln.split.to!(long[]);

    foreach (i, a; as) {
        if (i == 0) continue;
        if (as[i-1] + a >= L) {
            writeln("Possible");
            foreach (j; 1..i) writeln(j);
            foreach_reverse (j; i+1..N) writeln(j);
            writeln(i);
            return;
        }
    }
    writeln("Impossible");
}