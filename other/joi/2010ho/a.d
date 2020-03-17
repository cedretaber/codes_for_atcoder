import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto ss = [0];
    foreach (i; 0..N-1) ss ~= readln.chomp.to!int + ss[i];
    int s, i, j;
    foreach (_; 0..M) {
        i = j;
        j += readln.chomp.to!int;
        s = (s + ss[max(i, j)] - ss[min(i, j)]) % 10^^5;
    }
    writeln(s);
}