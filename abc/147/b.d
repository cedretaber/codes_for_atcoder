import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto len = S.length;
    int c;
    foreach (i; 0..len/2) {
        if (S[i] != S[len-i-1]) ++c;
    }
    writeln(c);
}