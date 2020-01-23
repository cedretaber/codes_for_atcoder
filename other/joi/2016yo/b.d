import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[] as;
    foreach (_; 0..N) as ~= readln.chomp.to!int;

    foreach (k; 1..M+1) {
        foreach (i; 0..N-1) {
            if (as[i]%k > as[i+1]%k) swap(as[i], as[i+1]);
        }
    }

    foreach (a; as) writeln(a);
}