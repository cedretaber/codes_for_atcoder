import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (x; N..1000) {
        if (x/100 == (x/10)%10 && (x/10)%10 == x%10) {
            writeln(x);
            return;
        }
    }
}