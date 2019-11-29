import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    sort(AS);
    long sum = AS[0];
    int c = 1;
    foreach (a; AS[1..$]) {
        if (sum*2 < a) {
            N -= c;
            c = 0;
        }
        ++c;
        sum += a;
    }
    writeln(N);
}