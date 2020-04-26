import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    bool[string] res;
    foreach (_; 0..N) {
        res[readln.chomp] = true;
    }
    writeln(res.length);
}