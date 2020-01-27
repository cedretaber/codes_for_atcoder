import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto a = readln.split.to!(int[]);
    auto A1 = a[0];
    auto A2 = a[1];
    auto b = readln.split.to!(int[]);
    auto B1 = b[0];
    auto B2 = b[1];
    auto C = readln.chomp.to!int;
    int[] res;
    if (A1 == C || A2 == C) {
        res ~= B1;
        res ~= B2;
    }
    if (B1 == C || B2 == C) {
        res ~= A1;
        res ~= A2;
    }
    sort(res);
    res = res.uniq().array();
    writeln(res.length);
    foreach (r; res) writeln(r);
}