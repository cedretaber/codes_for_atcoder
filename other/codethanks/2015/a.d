import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    if (A > B) swap(A, B);
    int r;
    if (A < 0 && B > 0) {
        r = -A*2 + B*2;
    } else {
        r = max(abs(A), abs(B)) * 2;
    }
    writeln(r);
}