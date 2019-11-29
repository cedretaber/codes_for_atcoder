import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp.to!(wchar[]);

    int cost;
    foreach_reverse (c; S[1..$]) {
        if (c == 'E') ++cost;
    }
    auto min_cost = cost;
    for (int p = 1; p < N; ++p) {
        if (S[p] == 'E') --cost;
        if (S[p-1] == 'W') ++cost;
        min_cost = min(cost, min_cost);
    }
    writeln(min_cost);
}