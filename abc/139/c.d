import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto HS = readln.split.to!(int[]);

    int c, max_c;
    foreach_reverse (i; 0..N) {
        if (i+1 == N) continue;
        if (HS[i] >= HS[i+1]) {
            ++c;
        } else {
            max_c = max(c, max_c);
            c = 0;
        }
    }
    writeln(max(c, max_c));
}