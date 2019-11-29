import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    char last;
    foreach (c; S) {
        if ((last == 'R' && c == 'B') || (last == 'G' && c == 'G')) {
            writeln("No");
            return;
        }
        last = c;
    }
    writeln(S[0] == 'R' && S[N-1] == 'B' ? "Yes" : "No");
}