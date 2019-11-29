import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto s = readln.chomp.to!(char[]);
    char[] S;
    for (size_t i; i < s.length; ++i) {
        if (i < s.length-1 && s[i] == 'B' && s[i+1] == 'C') {
            S ~= 'X';
            ++i;
        } else {
            S ~= s[i];
        }
    }
    long[] C;
    C.length = S.length;
    long cnt;
    foreach (i, c; S) {
        if (c == 'A') {
            ++cnt;
        } else if (c != 'X') {
            cnt = 0;
        }
        C[i] = cnt;
    }
    long r;
    foreach (i, c; S) if (c == 'X') r += C[i];
    writeln(r);
}