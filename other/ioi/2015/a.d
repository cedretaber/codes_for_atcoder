import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto t = readln.chomp.to!int;
    if (t == 45) {
        writeln(1);
        return;
    }

    int c = 1, x = t;
    while (x%90 != 0) {
        x += t;
        ++c;
    }
    writeln(c);
}