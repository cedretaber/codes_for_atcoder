import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    while (!S.empty) {
        if (S.endsWith("dream")) {
            S = S[0..$-5];
        } else if (S.endsWith("dreamer")) {
            S = S[0..$-7];
        } else if (S.endsWith("erase")) {
            S = S[0..$-5];
        } else if (S.endsWith("eraser")) {
            S = S[0..$-6];
        } else {
            break;
        }
    }
    writeln(S.empty ? "YES" : "NO");
}