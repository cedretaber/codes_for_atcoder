import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto x = readln.chomp.to!long;
    if (x < 7) {
        writeln(1);
    } else if (x < 12) {
        writeln(2);
    } else {
        auto ret = (x / 11) * 2;
        writeln(ret + (x%11 == 0 ? 0 : x%11 > 6 ? 2 : 1));
    }
}