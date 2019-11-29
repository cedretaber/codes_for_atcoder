import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto N = readln.chomp.to!int;
    auto A1 = readln.split.to!(int[]);
    auto A2 = readln.split.to!(int[]);

    A2[0] += A1[0];
    foreach (j; 1..N) {
        A1[j] += A1[j-1];
        A2[j] += A1[j] > A2[j-1] ? A1[j] : A2[j-1];
    }
    writeln(A2[N-1]);
}