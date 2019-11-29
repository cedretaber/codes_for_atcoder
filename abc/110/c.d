import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.to!(dchar[]);
    auto T = readln.to!(dchar[]);

    dchar[dchar] smemo, tmemo;
    foreach (i, s; S) {
        auto t = T[i];
        if (s in smemo && t in tmemo) {
            if (smemo[s] != t || tmemo[t] != s) {
                writeln("No");
                return;
            }
        } else if (s in smemo || t in tmemo) {
            writeln("No");
            return;
        } else {
            smemo[s] = t;
            tmemo[t] = s;
        }
    }
    writeln("Yes");
}