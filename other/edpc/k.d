import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

bool[10^^5+1] NS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    auto as = readln.split.to!(int[]);

    foreach (i; 0..K+1) {
        bool win;
        foreach (j; 0..N) if (i >= as[j] && !NS[i - as[j]]) {
            win = true;
            break;
        }
        NS[i] = win;
    }

    writeln(NS[K] ? "First" : "Second");
}