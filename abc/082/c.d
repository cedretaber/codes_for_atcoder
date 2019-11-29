import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[int] HS;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    foreach (a; as) {
        if (a in HS)
            ++HS[a];
        else
            HS[a] = 1;
    }
    int cnt;
    foreach (i, h; HS) {
        if (!h) continue;
        if (h > i) {
            cnt += h - i;
        } else if (h < i) {
            cnt += h;
        }
    }
    writeln(cnt);
}