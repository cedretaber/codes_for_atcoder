import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto T = readln.chomp.to!int;
    foreach (_; 0..T) {
        auto S = readln.chomp;
        int x;
        for (size_t i; i < S.length; ++i) {
            if (S.length - i < 5) break;
            if (S[i..i+5] == "tokyo" || S[i..i+5] == "kyoto") {
                i += 4;
                ++x;
            }
        }
        writeln(x);
    }
}