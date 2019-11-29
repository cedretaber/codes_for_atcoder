import std.stdio, std.string, std.array, std.conv, std.algorithm.iteration, std.functional;

void main()
{
    auto s = readln.chomp;
    auto n = s.length;
    foreach (c; s) {
        if (c == 'A') break;
        --n;
    }
    foreach_reverse (c; s) {
        if (c == 'Z') break;
        --n;
    }
    writeln(n);
}