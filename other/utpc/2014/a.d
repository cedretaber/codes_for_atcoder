import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.split;
    auto N = S.length;
    if (N < 3) {
        writeln(S.join(" "));
        return;
    }
    S = [""] ~ S;
    N += 1;
    string[] R;
    for (int i = N.to!int-1; i >= 0; --i) {
        R ~= S[i];
        if (i > 0 && S[i] != "not") {
            while (i > 2 && S[i-1] == "not" && S[i-2] == "not") {
                i -= 2;
            }
        }
    }
    R.reverse();
    writeln(R[1..$].join(" "));
}