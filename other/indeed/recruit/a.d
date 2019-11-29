import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkm = readln.split.to!(int[]);
    auto N = nkm[0];
    auto K = nkm[1];
    auto M = nkm[2];
    string[] SS;
    SS.length = N;
    foreach (i; 0..N) {
        SS[i] = readln.chomp.to!string;
    }
    foreach (s; SS[((M-1)*K)..min(M*K, $)]) {
        writeln(s);
    }
}