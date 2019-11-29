import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;

    auto head = S[0..7];
    auto tail = S[$-7..$];
    foreach (i; 0..8) {
        if (head[0..i] ~ tail[i..7] == "keyence") {
            writeln("YES");
            return;
        }
    }
    writeln("NO");
}