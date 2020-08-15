import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto S = readln.chomp;
    if (S == "RRR") {
        writeln(3);
    } else if (S == "SRR" || S == "RRS") {
        writeln(2);
    } else if (S == "SSS") {
        writeln(0);
    } else {
        writeln(1);
    }
}