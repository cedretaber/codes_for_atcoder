import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto Q = readln.chomp.to!int;
    foreach (_; 0..Q) {
        auto st = readln.split;
        auto S = st[0];
        auto T = st[1];
        bool[26] skip;
        foreach (c; T) skip[c-'a'] = true;
        string s;
        foreach (c; S) if (skip[c-'a']) s ~= c;
        if (s.length >= T.length) foreach (i; 0..s.length-T.length+1) {
            if (s[i..i+T.length] == T) {
                writeln("YES");
                goto ok;
            }
        }
        writeln("NO");
        continue;
        ok:
    }
}