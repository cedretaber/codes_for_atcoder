import std.stdio, std.string, std.conv, std.array, std.algorithm, std.range, std.math;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.chomp.split(" ").map!(to!int).array;

    auto av = as.reduce!"a+b" / n.to!double;
    auto av1 = ceil(av);
    auto ret1 = as.dup.map!(i => ((i - av1) ^^ 2).to!long).reduce!"a+b";

    av1 = floor(av);
    auto ret2 = as.dup.map!(i => ((i - av1) ^^ 2).to!long).reduce!"a+b";

    writeln(ret1 < ret2 ? ret1 : ret2);
}