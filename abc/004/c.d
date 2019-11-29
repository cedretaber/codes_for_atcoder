import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int % 30;
    auto x = [1,2,3,4,5,6];
    foreach (i; 0..N) {
        auto j = i%5;
        swap(x[j], x[j+1]);
    }
    writeln(x.map!(to!string).join);
}