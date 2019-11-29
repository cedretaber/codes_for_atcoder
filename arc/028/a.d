import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto nab = readln.split.to!(int[]);
    auto N = nab[0];
    auto A = nab[1];
    auto B = nab[2];

    while (N >= A+B) N -= A+B;
    writeln(N > 0 && N <= A ? "Ant" : "Bug");
}