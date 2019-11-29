import std.stdio, std.algorithm, std.conv, std.array, std.string;

int[10^^5] BS;
bool[10^^5] HS;

void main()
{
    auto n = readln.chomp.to!int;
    foreach (i; 0..n) {
        BS[i] = readln.chomp.to!int - 1;
    }

    int p, cnt;
    for (;;) {
        ++cnt;
        HS[p] = true;
        p = BS[p];
        if (p == 1) {
            writeln(cnt);
            return;
        }
        if (HS[p]) {
            writeln(-1);
            return;
        }
    }
}