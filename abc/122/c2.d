import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nq = readln.split.to!(int[]);
    auto N = nq[0];
    auto Q = nq[1];
    auto S = readln.chomp;
    auto cs = new int[](N);
    foreach (i; 1..N) {
        cs[i] += cs[i-1];
        if (S[i-1] == 'A' && S[i] == 'C') cs[i] += 1;
    }
    foreach (_; 0..Q) {
        auto lr = readln.split.to!(int[]);
        writeln(cs[lr[1]-1] - cs[lr[0]-1]);
    }
}