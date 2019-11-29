import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int c, max_c;
    foreach (a; readln.split) {
        if (a == "1") {
            ++c;
            max_c = max(max_c, c);
        } else {
            c = 0;
        }
    }
    writeln(max_c+1);
}