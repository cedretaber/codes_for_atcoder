import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    auto K = readln.chomp;

    int il;
    for (int i; i < S.length; ++i) {
        if (S[i] == '1') {
            ++il;
        } else break;
    }
    if (il == S.length) {
        writeln(1);
        return;
    } else if (!il) {
        writeln(S[0]);
        return;
    }
    auto n = S[il];

    if (K.length > 3 || K.to!int > il) {
        writeln(n);
    } else {
        writeln("1");
    }
}