import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    sort(as);
    int i, j = n-1, min_a = int.max, max_a = int.min;
    while (i < j) {
        auto s = as[i++] + as[j--];
        min_a = min(min_a, s);
        max_a = max(max_a, s);
    }
    writeln(max_a - min_a);
}