import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    while (!S.empty && S[0] != 'I') S = S[1..$];
    while (!S.empty && S[$-1] != 'I') S = S[0..$-1];
    if (S.empty) {
        writeln(0);
        return;
    }

    int i, c;
    while (i+1 < S.length) {
        ++i;
        if (S[i] != S[i-1]) ++c;
    }
    writeln(c + 1);
}