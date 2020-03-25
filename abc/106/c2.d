import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto K = readln.chomp.to!long;
    foreach (i; 0..K) {
        if (S[i] != '1' || i == K-1) {
            writeln(S[i]);
            return;
        }
    }
}