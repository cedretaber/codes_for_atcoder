import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[101] T;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (a; readln.split.to!(int[])) ++T[a];

    size_t i;
    for (;; ++i) {
        if (T[i] == 0) continue;
        break;
    }
    auto h = i.to!int;
    if (T[i] == 2) {
        --h;
    } else if (T[i] > 2) {
        writeln("Impossible");
        return;
    }
    int s = T[i];

    foreach (_; 0..h) {
        ++i;
        if (T[i] < 2) {
            writeln("Impossible");
            return;
        }
        s += T[i];
    }

    writeln(s == N ? "Possible" : "Impossible");
}