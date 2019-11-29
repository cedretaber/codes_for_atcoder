import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum YS = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto S = readln.chomp;
        foreach (i, y; YS) if (y == S) {
            writeln(YS[(i+1)%7]);
            break;
        }
    }
}