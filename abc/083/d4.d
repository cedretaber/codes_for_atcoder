import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int[] S;
    int n;
    char last;
    foreach (c; readln.chomp) {
        if (last && last == c) {
            ++n;
        } else {
            if (n) S ~= n;
            last = c;
            n = 1;
        }
    }
    S ~= n;
    if (S.length == 1) {
        writeln(S[0]);
        return;
    }

    while (S.length > 2) {
        if (S[0] < S[$-1]) {
            S[1] += S[0];
            S = S[1..$];
        } else {
            S[$-2] += S[$-1];
            S = S[0..$-1];
        }
    }
    writeln(max(S[0], S[1]));
}