import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;
    int r1, r2;
    foreach (i; 0..N) {
        auto c = i%2 == 0 ? '0' : '1';
        if (S[i] == c) ++r1; 
        if (S[i] != c) ++r2;
    }
    writeln(min(r1, r2));
}