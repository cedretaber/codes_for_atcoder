import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(wchar[]);
    int cnt = 1;
    wchar t = S[0];
    foreach (c; S[1..$]) {
        if (c <= t) {
            ++cnt;
            t = c;
        }
    }
    writeln(cnt);
}