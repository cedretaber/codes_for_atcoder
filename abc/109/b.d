import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

string[100] WS;
bool[string] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        WS[i] = readln.chomp;
    }
    char c = WS[0][0];
    foreach (w; WS[0..N]) {
        if (c != w[0] || w in MEMO) {
            writeln("No");
            return;
        }
        MEMO[w] = true;
        c = w[$-1];
    }
    writeln("Yes");
}