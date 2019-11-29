import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);

    while (!as.empty && as[$-1] == 0) as = as[0..$-1];

    if (as.empty) {
        writeln(0);
        return;
    }

    int c = 1, last = as[0];
    foreach (a; as[1..$]) {
        if (a < last) {
            ++c;
        }
        last = a;
    }
    writeln(c);
}