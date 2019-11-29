import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto B = readln.chomp.to!int;
    auto memo = new bool[](B);
    foreach_reverse (i; 0..B) {
        auto j = (i*1.5).to!int;
        if (j == B) {
            memo[i] = true;
        } else if (j < B) {
            memo[i] = memo[j];
        }
    }
    int r;
    foreach (m; memo) if (m) ++r;
    writeln(r);
}