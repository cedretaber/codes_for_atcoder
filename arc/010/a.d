import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nmab = readln.split.to!(int[]);
    auto N = nmab[0];
    auto M = nmab[1];
    auto A = nmab[2];
    auto B = nmab[3];

    foreach (i; 0..M) {
        if (N <= A) N += B;
        auto c = readln.chomp.to!int;
        if (N < c) {
            writeln(i+1);
            return;
        }
        N -= c;
    }
    writeln("complete");
}