import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp.to!(char[]);
    auto front = S[0..2];
    auto rear = S[2..$];

    auto front_ok = front != "00" && front.to!int <= 12;
    auto rear_ok = rear != "00" && rear.to!int <= 12;

    if (front_ok && rear_ok) {
        writeln("AMBIGUOUS");
    } else if (front_ok) {
        writeln("MMYY");
    } else if (rear_ok) {
        writeln("YYMM");
    } else {
        writeln("NA");
    }
}