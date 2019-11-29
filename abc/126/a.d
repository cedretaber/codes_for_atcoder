import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto K = nk[1]-1;
    auto S = readln.chomp.to!(char[]);
    if (S[K] == 'A') {
        S[K] = 'a';
    } else if (S[K] == 'B') {
        S[K] = 'b';
    } else if (S[K] == 'C') {
        S[K] = 'c';
    }
    writeln(S);
}