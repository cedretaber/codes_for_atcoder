import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto abc = readln.split.to!(int[]);
    sort(abc);
    auto A = abc[0];
    auto B = abc[1];
    auto C = abc[2];

    int r;
    r += (C-A)/2;
    A += (C-A)/2*2;
    r += (C-B)/2;
    B += (C-B)/2*2;

    if (A == C && B == C) {
        writeln(r);
    } else if (A == C || B == C) {
        writeln(r + 2);
    } else {
        writeln(r + 1);
    }
}