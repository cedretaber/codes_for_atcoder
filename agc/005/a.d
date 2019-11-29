import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto X = readln.chomp;
    int s, r;
    foreach (c; X) {
        if (c == 'S') {
            ++s;
        } else if (s > 0) {
            --s;
        } else {
            ++r;
        }
    }
    writeln(s + r);
}