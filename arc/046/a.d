import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    int i;
    for (;;) {
        ++i;
        if (i.to!(dchar[]).sort().uniq.array.length == 1) if (--N == 0) {
            writeln(i);
            return;
        }
    }
}