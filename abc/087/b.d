import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

void main()
{
    auto A = readln.chomp.to!int;
    auto B = readln.chomp.to!int;
    auto C = readln.chomp.to!int;
    auto X = readln.chomp.to!int;

    int result;
    foreach (a; 0..A+1) {
        foreach (b; 0..B+1) {
            auto rest = X - 500*a - 100*b;
            if (rest >= 0 && rest % 50 == 0 && rest / 50 <= C) ++result;
        }
    }
    writeln(result);
}