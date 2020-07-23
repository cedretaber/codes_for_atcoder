import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new int[](N);
    auto bs = new int[](N);
    foreach (i, p; readln.split.to!(int[])) {
        as[p-1] = i.to!int+1;
        bs[p-1] = i.to!int+1;
    }
    foreach (i; 0..N) {
        if (i) {
            as[i] += as[i-1];
            bs[N-i-1] += bs[N-i];
        }
    }
    writeln(as.to!(string[]).join(" "));
    writeln(bs.to!(string[]).join(" "));
}