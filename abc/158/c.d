import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];
    foreach (n; 1..20000) {
        if ((n*0.08).to!int == A && (n*0.1).to!int == B) {
            writeln(n);
            return;
        }
    }
    writeln(-1);
}