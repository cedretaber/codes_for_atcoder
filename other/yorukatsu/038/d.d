import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    while (!S.empty) {
        if (S.length >= 5 && S[$-5..$] == "dream") {
            S = S[0..$-5];
        } else if (S.length >= 7 && S[$-7..$] == "dreamer") {
            S = S[0..$-7];
        } else if (S.length >= 5 && S[$-5..$] == "erase") {
            S = S[0..$-5];
        } else if (S.length >= 6 && S[$-6..$] == "eraser") {
            S = S[0..$-6];
        } else {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}