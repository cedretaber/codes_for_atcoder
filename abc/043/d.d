import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range, std.math;

void main()
{
    auto s = readln.chomp;

    char last1 = s[0];
    char last2 = s[1];

    if (last1 == last2) {
        writeln("1 2");
        return;
    } else if (s.length == 2) {
        writeln("-1 -1");
        return;
    }

    foreach (long i, c; s[2..$]) {
        if (last1 == c || last2 == c) {
            writefln("%d %d", i+1, i+3);
            return;
        }
        last1 = last2;
        last2 = c;
    }

    writeln("-1 -1");
}