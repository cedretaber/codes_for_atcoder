import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    for (;;) {
        if (S.empty) break;
        if (S.length >= 2 && S[0..2] == "hi") {
            S = S[2..$];
        } else {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}