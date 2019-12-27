import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int b, w;
    foreach (_; 0..N) {
        if (readln.chomp == "black") {
            ++b;
        } else {
            ++w;
        }
    }
    writeln(b > w ? "black" : "white");
}