import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto x = readln.chomp.to!long;
    long r = x / 11L * 2;
    if (x%11L >= 7) {
        r += 2;
    } else if (x%11L >= 1) {
        r += 1;
    }
    writeln(r);
}