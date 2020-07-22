import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    auto a_max = as.maxElement;

    if (as.all!(a => a == a_max) && a_max+1 == N) {
        writeln("Yes");
        return;
    }

    int c = a_max, n = N;
    foreach (a; as) {
        if (a == a_max-1) {
            --c;
            --n;
        } else if (a != a_max) {
            writeln("No");
            return;
        }
    }
    writeln(c < 1 || c*2 > n ? "No" : "Yes");
}