import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto T = readln.chomp.to!(char[]);
    auto N = S.length;
    auto M = T.length;
    foreach_reverse (i; 0..N-M+1) {
        foreach (j; 0..M) {
            if (S[i+j] != '?' && S[i+j] != T[j]) goto ng;
        }
        S[i..i+M] = T[];
        goto ok;
        ng:
    }
    writeln("UNRESTORABLE");
    return;
    ok:
    foreach (ref c; S) if (c == '?') c = 'a';
    writeln(S);
}