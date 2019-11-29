import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto t = ["okyo", "ech"];
    foreach (_; 0..N) {
        auto S = readln.chomp;
        size_t i;
        while (!S.empty && i < 2) {
            if (S.length >= t[i].length && S[0..t[i].length] == t[i]) {
                S = S[t[i].length..$];
                ++i;
            } else {
                S = S[1..$];
            }
        }
        writeln(i == 2 ? "Yes" : "No");
    }
}